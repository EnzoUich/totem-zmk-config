# ZMK Config for Totem Keyboard

ZMK firmware configuration for the Totem 38-key split keyboard with dongle support.

## Layout

This configuration uses the **Miryoku layout** with QWERTY base layer and **INVERTEDT** navigation/mouse/media layers. Home row mods are configured for same-hand modifier combinations.

### Base Layer (QWERTY)

```
Q     W     E     R     T  |  Y     U     I      O      P
GUI-A ALT-S CTRL-D SFT-F G  |  H  SFT-J CTRL-K RALT-L GUI-'
Z     X     C     V     B  |  N     M     ,      .      /
```

**Thumbs (layer-tap):**
```
MEDIA-ESC  NAV-SPACE  MOUSE-TAB  |  SYM-RET  NUM-BSPC  FUN-DEL
```

### Layers

- **BASE (0)**: QWERTY with home row mods (GACS order)
- **NAV (1)**: Navigation INVERTEDT (arrows on right, modifiers on left)
- **MOUSE (2)**: Mouse INVERTEDT (mouse controls on right, modifiers on left)
  - Right thumb: MCLK (middle click), LCLK (left click), RCLK (right click)
- **MEDIA (3)**: Media INVERTEDT (media controls on right, modifiers on left)
- **NUM (4)**: Number pad with symbols
- **SYM (5)**: Shifted symbols
- **FUN (6)**: Function keys (F1-F12)

## Homerow Mods

Hybrid homerow mods configuration:

- **Flavor**: `balanced`
- **Tapping term**: 280ms
- **Quick tap**: 175ms
- **Prior idle**: 150ms
- **Left hand**: Same-hand modifiers enabled (no hold trigger restrictions) - allows Ctrl+Shift+V
- **Right hand**: Urob's timeless config (opposite hand trigger only) - prevents accidental triggers

This asymmetric configuration allows same-hand modifier combos on the left hand while maintaining reliable typing on the right hand.

## Hardware

- **Board**: Seeeduino XIAO BLE
- **Keyboard**: Totem (38 keys)
- **Dongle**: Totem dongle for wireless receiver
- **Features**:
  - Mouse/pointing support
  - ZMK Studio support (via dongle)
  - Battery level monitoring with RGB LED indicator
    - Uses [zmk-rgbled-widget](https://github.com/caksoylar/zmk-rgbled-widget) with rgbled_adapter
    - Shows each keyboard's own battery level (left/right/dongle)
    - High level: >80%, Low level: <20%
    - Battery voltage: 4.2V (100%) to 3.45V (0%)
  - BT transmit power +8dBm
  - Deep sleep mode (30 minute idle timeout)
  - Wakeup-source configured (kscan)

## Building

Firmware is automatically built via GitHub Actions on push to `totem-dongle` branch.

## Downloading & Flashing Firmware

### Prerequisites

- [GitHub CLI](https://cli.github.com/) (`gh`) installed
- Authenticated with GitHub (`gh auth login`)

### Download Firmware

```bash
# Download latest firmware from default branch
./download-firmware.sh

# Download from specific branch
./download-firmware.sh main
```

Firmware is downloaded to `firmware/` directory.

### Flash Firmware

```bash
# Flash dongle
./flash-firmware.sh dongle

# Flash left keyboard half
./flash-firmware.sh left

# Flash right keyboard half
./flash-firmware.sh right

# Reset settings (clears all stored settings)
./flash-firmware.sh reset
```

### Flashing Process

1. Put your XIAO BLE Sense in bootloader mode (double-tap reset button)
2. Device should mount as "XIAO-SENSE"
3. Script will wait up to 10 seconds for device to appear
4. Firmware will be copied automatically
5. Device will reboot with new firmware

**Tip:** Use `./flash-firmware.sh reset` to clear all settings if you're experiencing issues after firmware updates.

## Configuration Files

- `config/totem.keymap` - Main keymap configuration
- `config/totem.conf` - Build configuration
- `build.yaml` - GitHub Actions build targets

## References

- [Miryoku layout](https://github.com/manna-harbour/miryoku)
- [urob's timeless homerow mods](https://github.com/urob/zmk-config)
- [ZMK Firmware](https://zmk.dev/)
