# Hyprland

Installation and setup of Hyprland

## Install

- `yay -S hyprland-git`
- `sudo pacman -S kitty`

## UWSM

- Install `yay -S uwsm`

Modify startup shell profile to include WIP

``` bash
if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
```

Use UWSM to start applications inside session `uwsm app --`
