#!/usr/bin/env bash
## /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for refreshing waybar, rofi, swaync, pywal colors

# Kill already running processes
_ps=(waybar rofi swaync)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"   # Gracefully kill the processes
        sleep 0.1          # Wait for processes to terminate
    fi
done

# Relaunch waybar
sleep 0.5
if ! pidof waybar >/dev/null; then
    waybar > /dev/null 2>&1 &   # Start waybar if it's not running
fi

# Relaunch swaync
if ! pidof swaync >/dev/null; then
    swaync > /dev/null 2>&1 &   # Start swaync if it's not running
fi

# For cava-pywal (note, need to manually restart cava once wallpaper changes)
ln -sf "$HOME/.cache/wal/cava-colors" "$HOME/.config/cava/config" || true

exit 0
