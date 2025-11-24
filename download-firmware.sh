#!/bin/bash

# Script to download firmware from latest GitHub Actions run
# Usage: ./download-firmware.sh [branch] [--flash]
# Options:
#   --flash    Copy totem_dongle firmware to XIAO-SENSE device

set -e

REPO="lchojnack/zmk-config"
BRANCH="totem-dongle"
OUTPUT_DIR="firmware"
FLASH=false

# Parse arguments
for arg in "$@"; do
    if [ "$arg" = "--flash" ]; then
        FLASH=true
    else
        BRANCH="$arg"
    fi
done

echo "Fetching latest workflow run for branch: $BRANCH"

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI (gh) is not installed."
    echo "Install it from: https://cli.github.com/"
    exit 1
fi

# Get the latest successful workflow run for the branch
RUN_ID=$(gh run list \
    --repo "$REPO" \
    --branch "$BRANCH" \
    --workflow build.yml \
    --status success \
    --limit 1 \
    --json databaseId \
    --jq '.[0].databaseId')

if [ -z "$RUN_ID" ]; then
    echo "Error: No successful workflow runs found for branch $BRANCH"
    exit 1
fi

echo "Found workflow run: $RUN_ID"
echo "Downloading artifacts..."

# Clean and create output directory
if [ -d "$OUTPUT_DIR" ]; then
    echo "Cleaning existing firmware directory..."
    rm -rf "$OUTPUT_DIR"
fi
mkdir -p "$OUTPUT_DIR"

# Download all artifacts from the run
gh run download "$RUN_ID" \
    --repo "$REPO" \
    --dir "$OUTPUT_DIR"

echo ""
echo "✓ Firmware downloaded successfully to: $OUTPUT_DIR/"
echo ""
echo "Contents:"
ls -lh "$OUTPUT_DIR"

# Flash firmware if requested
if [ "$FLASH" = true ]; then
    echo ""
    echo "Looking for totem_dongle firmware..."

    # Find the totem_dongle UF2 file
    DONGLE_FW=$(find "$OUTPUT_DIR" -name "*totem_dongle*.uf2" -type f | head -n 1)

    if [ -z "$DONGLE_FW" ]; then
        echo "Error: totem_dongle firmware not found"
        exit 1
    fi

    echo "Found: $DONGLE_FW"
    echo ""
    echo "Waiting for XIAO-SENSE device (10s timeout)..."

    # Wait for device to appear (10 second timeout)
    MOUNT_POINT=""
    TIMEOUT=10
    ELAPSED=0

    while [ $ELAPSED -lt $TIMEOUT ]; do
        for path in /media/$USER/XIAO-SENSE /media/XIAO-SENSE /run/media/$USER/XIAO-SENSE; do
            if [ -d "$path" ]; then
                MOUNT_POINT="$path"
                break 2
            fi
        done
        sleep 1
        ELAPSED=$((ELAPSED + 1))
        echo -n "."
    done
    echo ""

    if [ -z "$MOUNT_POINT" ]; then
        echo "Error: XIAO-SENSE device not found"
        echo "Please put your device in bootloader mode (double-tap reset button)"
        exit 1
    fi

    echo "Found device at: $MOUNT_POINT"
    echo "Copying firmware..."

    cp "$DONGLE_FW" "$MOUNT_POINT/"
    sync

    echo ""
    echo "✓ Firmware flashed successfully!"
    echo "Device will reboot automatically"
fi
