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
    "github-cli"
)
paru -S --needed "${BASE_PACKAGES[@]}"
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to install base packages."
    exit 1
fi

# Prompt the use to login to GitHub CLI
echo "Please log in to GitHub CLI if you haven't already."
gh auth login
if [[ $? -ne 0 ]]; then
    echo "Error: GitHub CLI login failed."
    exit 1
fi

# Install the Rosé Pine GTK theme
echo "Installing Rosé Pine GTK theme..."
ROSE_PINE_PACKAGES=(
    "gtk3"
    "gtk4"
    "rose-pine-icons"
)
ROSE_PINE_VERSION=$(gh release list -R rose-pine/gtk | grep -oP 'v\d+\.\d+\.\d+' | head -n 1)
if [[ -z "$ROSE_PINE_VERSION" ]]; then
    echo "Error: Could not determine the latest Rosé Pine GTK version."
    exit 1
fi
gh release download -R rose-pine/gtk "$ROSE_PINE_VERSION" --pattern 'gtk3.tar.gz' --pattern 'gtk4.tar.gz' --pattern 'rose-pine-icons.tar.gz'
# Extract and install the GTK themes
mkdir -p "$HOME/.themes"
tar -xzf "gtk3.tar.gz" -C "$HOME/.themes"
mkdir -p "$HOME/.config/gtk-4.0"
tar -xzf "gtk4.tar.gz" -C "$HOME/.config/gtk-4.0"
mv "$HOME/.config/gtk-4.0/rose-pine.css" "$HOME/.config/gtk-4.0/gtk.css"
mkdir -p "$HOME/.icons"
tar -xzf "rose-pine-icons.tar.gz" -C "$HOME/.icons"
# Set the GTK theme
echo "Setting GTK theme to Rosé Pine..."
echo "gtk-theme-name='Rose Pine'" >> "$HOME/.config/gtk-3.0/settings.ini"
echo "gtk-theme-name='Rose Pine'" >> "$HOME/.config/gtk-4.0/settings.ini"
echo "gtk-icon-theme-name='Rose Pine'" >> "$HOME/.config/gtk-3.0/settings.ini"
echo "gtk-icon-theme-name='Rose Pine'" >> "$HOME/.config/gtk-4.0/settings.ini"

# Install Starship
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh
# Configure Starship with the Rosé Pine theme
echo "Getting Rosé Pine for Starship..."
STARSHIP_THEME_URL="https://raw.githubusercontent.com/rose-pine/starship/refs/heads/main/rose-pine.toml"
curl -o "$HOME/.config/starship.toml" "$STARSHIP_THEME_URL"

# Prompt the user for their preferred shell
echo "Which shell do you prefer? (bash/zsh/fish)"
read -r SHELL_CHOICE
case "$SHELL_CHOICE" in
    bash)
        echo "Setting up Bash..."
        if ! grep -q "source \$HOME/.config/starship.toml" "$HOME/.bashrc"; then
            echo "source \$HOME/.config/starship.toml" >> "$HOME/.bashrc"
        fi

        if ! grep -q "set shell" "$HOME/.config/kitty/kitty.conf"; then
            echo "set shell $SHELL" >> "$HOME/.config/kitty/kitty.conf"
        fi
        ;;
    zsh)
        echo "Setting up Zsh..."
        # Install Zsh if not already installed
        if ! command -v zsh &> /dev/null; then
            sudo paru -S --needed zsh
        fi

        if ! grep -q "source \$HOME/.config/starship.toml" "$HOME/.zshrc"; then
            echo "source \$HOME/.config/starship.toml" >> "$HOME/.zshrc"
        fi

        if ! grep -q "set shell" "$HOME/.config/kitty/kitty.conf"; then
            echo "set shell $SHELL" >> "$HOME/.config/kitty/kitty.conf"
        fi
        ;;
    fish)
        echo "Setting up Fish..."
        # Install Fish if not already installed
        if ! command -v fish &> /dev/null; then
            sudo paru -S --needed fish
        fi

        if ! grep -q "starship init fish | source" "$HOME/.config/fish/config.fish"; then
            echo "starship init fish | source" >> "$HOME/.config/fish/config.fish"
        fi

        if ! grep -q "set shell" "$HOME/.config/kitty/kitty.conf"; then
            echo "set shell $SHELL" >> "$HOME/.config/kitty/kitty.conf"
        fi
        ;;
    *)
        echo "Unsupported shell: $SHELL_CHOICE. Please set up Starship manually."
        ;;
esac

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
