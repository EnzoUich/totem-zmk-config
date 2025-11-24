# ZMK Config for Totem Keyboard

ZMK firmware configuration for the Totem 38-key split keyboard with dongle support.

## Layout

This configuration uses the **Miryoku layout** with QWERTY base layer and **timeless homerow mods** from [urob's zmk-config](https://github.com/urob/zmk-config).

### Base Layer (QWERTY)

```
Q     W     E     R     T  |  Y     U     I     O     P
GUI-A ALT-S CTRL-D SFT-F G  |  H  SFT-J CTRL-K ALT-L GUI-'
Z     X     C     V     B  |  N     M     ,     .     /
```

**Thumbs (layer-tap):**
```
MEDIA-ESC  NAV-SPACE  MOUSE-TAB  |  SYM-RET  NUM-BSPC  FUN-DEL
```

### Layers

- **BASE (0)**: QWERTY with home row mods (GACS order)
- **NAV (1)**: Navigation (arrows, page controls, clipboard)
- **MOUSE (2)**: Mouse emulation (movement, scroll, buttons)
- **MEDIA (3)**: Media controls (volume, play/pause, prev/next)
- **NUM (4)**: Number pad with symbols
- **SYM (5)**: Shifted symbols
- **FUN (6)**: Function keys (F1-F12)

## Timeless Homerow Mods

Configuration based on [urob's timeless homerow mods](https://github.com/urob/zmk-config?tab=readme-ov-file#timeless-homerow-mods):

- **Flavor**: `balanced`
- **Tapping term**: 280ms
- **Quick tap**: 175ms
- **Prior idle**: 350ms (tuned for 30 WPM = 10500 / WPM)
- **Hold trigger**: Opposite hand + thumbs
- **Hold on release**: Enabled

## Hardware

- **Board**: Seeeduino XIAO BLE
- **Keyboard**: Totem (38 keys)
- **Dongle**: Totem dongle for wireless receiver
- **Features**:
  - Mouse/pointing support
  - ZMK Studio support (via dongle)
  - Battery level monitoring
  - BT transmit power +8dBm

## Building

Firmware is automatically built via GitHub Actions on push to `totem-dongle` branch.

## Downloading & Flashing Firmware

Use the `download-firmware.sh` script to download and optionally flash firmware:

### Prerequisites

- [GitHub CLI](https://cli.github.com/) (`gh`) installed
- Authenticated with GitHub (`gh auth login`)

### Usage

```bash
# Download firmware only
./download-firmware.sh

# Download and flash to XIAO-SENSE dongle
./download-firmware.sh --flash

# Download from specific branch
./download-firmware.sh main

# Download from specific branch and flash
./download-firmware.sh main --flash
```

### Flashing

When using `--flash`:
1. Put your XIAO BLE Sense in bootloader mode (double-tap reset button)
2. Device should mount as "XIAO-SENSE"
3. Script will wait up to 10 seconds for device to appear
4. Firmware will be copied automatically
5. Device will reboot with new firmware

Firmware is downloaded to `firmware/` directory.

## Configuration Files

- `config/totem.keymap` - Main keymap configuration
- `config/totem.conf` - Build configuration
- `build.yaml` - GitHub Actions build targets

## References

- [Miryoku layout](https://github.com/manna-harbour/miryoku)
- [urob's timeless homerow mods](https://github.com/urob/zmk-config)
- [ZMK Firmware](https://zmk.dev/)
