**Hyprland Configuration Files**
=====================================

This directory contains configuration files for the Hyprland window manager. These files customize various aspects of the display, keyboard layout, and other settings to provide a unique experience.

**Overview**
------------

The configuration files in this directory are written in various formats, including JSON, YAML, CSS, and shell scripts. They use commands specific to each file format to set up customizations such as:

* Waybar layouts
* Waybar styles
* Wallpaper selection
* Sound and music control
* Keyboard layout
* Animation settings

**Dependencies**
-----------------

To install all dependencies for this project, follow these steps:

### Install Dependencies

1. **Install Hyprland**: `sudo apt-get install hyprland`
2. **Install Rofi**: `sudo apt-get install rofi`
3. **Install Waybar**: `sudo apt-get install waybar`
4. **Install Kitty**: `sudo apt-get install kitty`
5. **Install rofi-waybar**: `sudo apt-get install rofi-waybar`
6. **Install wlogout**: `sudo apt-get install wlogout`

### Install Themes

1. **Install Nova Dark Theme**: `sudo apt-get install nova-dark-theme`
2. **Download icons**: `wget https://example.com/icons.tar.gz` (replace with actual URL)

**Configuration Files**
-----------------------

The configuration files in this directory are organized into the following subdirectories:

* `animations`: Custom animation settings for Hyprland.
* `keybinds`: Keyboard binding configurations for Hyprland.
* `settings`: General settings for Hyprland, including monitor settings and window manager options.
* `startup`: Startup scripts for Hyprland, including waybar and sound control.
* `variables`: Environment variable settings for Hyprland.
* `window_rules`: Window rule definitions for customizing the display.
* `hypridle`: Configuration files for Hypridle, a screenlock utility.

**Waybar Configuration Files**
-----------------------------

The waybar configuration files in this directory are organized into the following subdirectories:

* `rofi-waybar`
* `wlogout-waybar`
* `kitty-waybar`

These directories contain various configuration files that customize the appearance and behavior of the waybar.
