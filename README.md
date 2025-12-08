# ZMK Config for Totem Keyboard

ZMK firmware configuration for the Totem 38-key split keyboard with dongle support.

## Layout

This configuration uses the **Miryoku layout** with QWERTY base layer, **FLIP+INVERTEDT variant**, and **timeless homerow mods** from [urob's zmk-config](https://github.com/urob/zmk-config).

### Miryoku Variant

- **MIRYOKU_LAYERS=FLIP**: Flips layer access and content between hands
- **MIRYOKU_NAV=INVERTEDT**: Inverted-T navigation arrangement (UP above DOWN on home row)

### Base Layer (QWERTY)

```
Q     W     E     R     T  |  Y     U     I     O     P
GUI-A ALT-S CTRL-D SFT-F G  |  H  SFT-J CTRL-K ALT-L GUI-;
Z     X     C     V     B  |  N     M     ,     .     /
```

**Thumbs (layer-tap):**
```
FUN-DEL  NUM-BSPC  SYM-RET  |  MOUSE-TAB  NAV-SPACE  MEDIA-ESC
```

### Layers

- **BASE (0)**: QWERTY with home row mods (GACS order)
- **NAV (1)**: Navigation with inverted-T arrows (left hand) + modifiers (right hand)
- **MOUSE (2)**: Mouse emulation with inverted-T movement (left hand) + modifiers (right hand)
- **MEDIA (3)**: Media controls with inverted-T layout (left hand) + modifiers (right hand)
- **NUM (4)**: Modifiers (left hand) + number pad (right hand)
- **SYM (5)**: Modifiers (left hand) + symbols (right hand)
- **FUN (6)**: Modifiers (left hand) + function keys (right hand)

## Timeless Homerow Mods

Configuration based on [urob's timeless homerow mods](https://github.com/urob/zmk-config?tab=readme-ov-file#timeless-homerow-mods):

- **Flavor**: `balanced`
- **Tapping term**: 280ms
- **Quick tap**: 175ms
- **Prior idle**: 150ms
- **Same-hand modifiers**: Enabled (no hold-trigger restrictions)

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
- [Miryoku ZMK](https://github.com/manna-harbour/miryoku_zmk)
- [Miryoku reference manual](https://github.com/manna-harbour/miryoku/tree/master/docs/reference)
- [urob's timeless homerow mods](https://github.com/urob/zmk-config)
- [ZMK Firmware](https://zmk.dev/)
