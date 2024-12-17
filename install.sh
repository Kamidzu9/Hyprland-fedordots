#!/bin/bash

# List of packages to install
PACKAGES=(
  hyprlock pywal btop nvtop swaync bluetui pavucontrol wlogout swaylock thunar
  hypridle cargo rustc swww nwg-look cmake gcc g++ make automake autoconf
  libtool pkg-config golang cairo-devel gobject-introspection-devel cairo-gobject-devel
)

# Ensure DNF is installed
if ! command -v dnf &>/dev/null; then
  echo "[ERROR] DNF is not installed. Please install it before running this script."
  exit 1
fi

# Prompt user to install all packages
echo "The following packages will be installed:"
printf "%s\n" "${PACKAGES[@]}"
read -p "Do you want to install all packages? (y/n): " response

if [[ "${response,,}" == "y" ]]; then
  echo "[INFO] Installing all packages..."
  sudo dnf install -y "${PACKAGES[@]}"
else
  echo "[INFO] Skipping bulk installation."
  echo "[INFO] You can manually install individual packages as needed."
fi

# Check if Zed is already installed
if command -v zed &>/dev/null; then
  echo "[INFO] Zed is already installed. Skipping installation."
else
  # Prompt for Zed installation
  read -p "Zed is not installed. Do you want to install it? (y/n): " zed_response
  if [[ "${zed_response,,}" == "y" ]]; then
    echo "[INFO] Installing Zed..."
    curl -f https://zed.dev/install.sh | sh
  else
    echo "[INFO] Skipping Zed installation."
  fi
fi

# Ensure ~/Pictures directory exists
if [ ! -d "$HOME/Pictures/" ]; then
  echo "[INFO] Creating ~/Pictures/ directory."
  mkdir -p "$HOME/Pictures/"
fi

# Copy configuration and picture files
echo "[INFO] Copying configuration files to ~/.config/"
mkdir -p "$HOME/.config/"
for dir in */; do
  echo "[INFO] Copying $dir to ~/.config/"
  cp -r "$dir" "$HOME/.config/"
done

echo "[INFO] Copying ./Pictures/ to ~/Pictures/"
cp -r "./Pictures/" "$HOME/"

echo "[INFO] Installation and setup complete!"
