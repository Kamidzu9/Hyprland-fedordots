#!/bin/bash

# List of packages to install
PACKAGES=(
  hyprlock btop nvtop swaync pavucontrol wlogout swaylock thunar
  hypridle cargo rustc lxappearance cmake gcc g++ make automake autoconf
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
# Ensure pip3 is installed
if ! command -v pip3 &>/dev/null; then
  echo "[INFO] pip3 is not installed. Installing pip3..."
  sudo dnf install -y python3-pip
else
  echo "[INFO] pip3 is already installed. Skipping installation."
fi

# Check if pywal is installed
if ! pip3 show pywal &>/dev/null; then
  echo "[INFO] pywal is not installed. Installing pywal using pip3..."
  sudo pip3 install pywal
else
  echo "[INFO] pywal is already installed. Skipping installation."
fi

# Check if user wants to install swww from Git
read -p "[INFO] Do you want to install swww from Git? (y/n): " install_swww
if [[ "${install_swww,,}" == "y" ]]; then
  echo "[INFO] Checking if swww is installed..."

  if command -v swww &>/dev/null; then
    echo "[INFO] swww is already installed. Skipping installation."
  else
    echo "[INFO] swww is not installed. Installing from Git..."

    # Install dependencies
    echo "[INFO] Installing dependencies for swww..."
    sudo dnf install -y git cargo

    # Clone the repository and build
    git clone https://github.com/LGFae/swww.git
    cd swww || exit
    echo "[INFO] Building swww using cargo..."
    cargo build --release

    # Place binaries in the path
    echo "[INFO] Placing swww binaries in /usr/local/bin/"
    sudo cp target/release/swww /usr/local/bin/
    sudo cp target/release/swww-daemon /usr/local/bin/

    # Optional - Autocompletion scripts
    read -p "[INFO] Do you want to install autocompletion scripts? (y/n): " response
    if [[ "${response,,}" == "y" ]]; then
      echo "[INFO] Installing autocompletion scripts..."
      sudo cp completions/* /etc/bash_completion.d/ 2>/dev/null || echo "[INFO] Autocompletion scripts skipped."
    else
      echo "[INFO] Skipping autocompletion scripts installation."
    fi

    # Remove the cloned repository folder after installation
    echo "[INFO] Cleaning up by removing the swww repository folder..."
    cd ..
    rm -rf swww

    echo "[INFO] swww installed successfully."
  fi
else
  echo "[INFO] Skipping swww installation."
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
