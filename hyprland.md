# Hyprland

Installation and setup of Hyprland

## Installation

It is recommended **not** to use the `-git` versions of hyprland.

- `sudo pacman -S hyprland kitty uwsm`

Modify startup shell profile to include WIP

``` bash
if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
```

Use UWSM to start applications inside session `uwsm app --`
