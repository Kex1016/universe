echo "Installing Hyprland and dependencies..."
# Update the system
sudo pacman -Syu

ORIG_DIR=$(pwd)
SCRIPT_TMP_DIR="$HOME/.cakeland"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$SCRIPT_TMP_DIR"

echo "Original directory: $ORIG_DIR"
echo "Script directory: $SCRIPT_DIR"
echo "Temporary directory: $SCRIPT_TMP_DIR"

cd "$SCRIPT_TMP_DIR"

# Set up bare minimum packages
echo "Setting up bare minimum packages..."
sudo pacman -S --needed base-devel git

# Set up paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd "$SCRIPT_DIR"

# Install base deps
echo "Installing dependencies..."
BASE_PACKAGES=(
    "rsync"
    "hyprland"
    "hyprpicker"
    "hyprpaper"
    "hyprlock"
    "hyprcap"
    "hypridle"
    "hyprcursor"
    "hyprsysteminfo"
    "hyprpolkitagent"
    "hyprsunset"
    "xdg-utils"
    "xdg-desktop-portal-hyprland"
    "waybar"
    "qt5-wayland"
    "qt6-wayland"
    "pipewire"
    "wireplumber"
    "grim"
    "slurp"
    "rofi"
    "copyq"
    "networkmanager"
    "nm-applet"
    "udiskie"
    "nemo"
    "nemo-fileroller"
    "nemo-terminal"
    "nemo-preview"
    "nemo-share"
    "nemo-image-converter"
    "nemo-audio-tab"
    "nemo-emblems"
    "nemo-seahorse"
    "nemo-compare"
    "playerctl"
)
paru -S --needed "${BASE_PACKAGES[@]}"

# optional packages
echo "Do you want to install optional packages? (y/n)"
read -r INSTALL_ADDITIONAL
if [[ "$INSTALL_ADDITIONAL" == "y" || "$INSTALL_ADDITIONAL" == "Y" ]]; then
    ADDITIONAL_PACKAGES=(
        "equibop-bin"
    )
    paru -S --needed "${ADDITIONAL_PACKAGES[@]}"
else
    echo "Skipping additional packages installation."
fi

# Copy configuration files using rsync (current directory to home directory excluding install.sh and .git)
echo "Copying configuration files..."
rsync -av --exclude='install.sh' --exclude='.git' --exclude='README.md' "$SCRIPT_DIR/" "$HOME/"
