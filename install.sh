#!/bin/bash

# List of packages to install
PACKAGES=(hyprlock pywal btop nvtop swaync bluetui pavucontrol wlogout swaylock thunar hypridle)

# Function to update and install packages using a detected package manager
install_packages() {
  local pm_update="$1"
  local pm_install="$2"
  local pm_check="$3"

  echo "[INFO] Updating package manager with command: $pm_update"
  sudo $pm_update

  echo "[INFO] Checking package availability: ${PACKAGES[*]}"
  for package in "${PACKAGES[@]}"; do
    echo "[INFO] Checking availability of package: $package"
    if ! $pm_check "$package" >/dev/null 2>&1; then
      echo "[ERROR] Package $package not found. Exiting."
      exit 1
    fi
  done

  echo "[INFO] Installing packages: ${PACKAGES[*]}"
  for package in "${PACKAGES[@]}"; do
    echo "[INFO] Installing package: $package using command: $pm_install"
    sudo $pm_install "$package"
  done
}

# Detect the package manager
if command -v dnf >/dev/null 2>&1; then
  echo "[INFO] Detected DNF package manager."
  install_packages "dnf update -y" "dnf install -y" "dnf list"
elif command -v apt >/dev/null 2>&1; then
  echo "[INFO] Detected APT package manager."
  install_packages "apt update" "apt install -y" "apt-cache show"
elif command -v pacman >/dev/null 2>&1; then
  echo "[INFO] Detected Pacman package manager."
  install_packages "pacman -Syu --noconfirm" "pacman -S --noconfirm" "pacman -Si"
elif command -v zypper >/dev/null 2>&1; then
  echo "[INFO] Detected Zypper package manager."
  install_packages "zypper refresh" "zypper install -y" "zypper info"
elif command -v emerge >/dev/null 2>&1; then
  echo "[INFO] Detected Portage package manager."
  install_packages "emerge --sync" "emerge" "emerge -s"
else
  echo "[ERROR] No compatible package manager detected. Please install the packages manually."
  exit 1
fi

# Copy all folders from the current directory to ~/.config/
echo "[INFO] Copying folders from ./ to ~/.config/"
for dir in */; do
  echo "[INFO] Copying $dir to ~/.config/"
  cp -r "$dir" ~/.config/
done
echo "[INFO] All folders copied to ~/.config/"

echo "[INFO] All done!"
