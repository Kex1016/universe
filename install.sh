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
sudo pacman --noconfirm -S --needed base-devel git rsync

# Set up yay if not already installed
if ! command -v yay &> /dev/null; then
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd "$SCRIPT_DIR"
else
    echo "Yay is already installed."
fi

# Install base deps
echo "Installing dependencies..."
BASE_PACKAGES=(
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
    "kitty"
    "mpv"
    "neovim"
)
yay --noconfirm -S --needed "${BASE_PACKAGES[@]}"
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to install base packages."
    exit 1
fi

# Install login manager
echo "Installing ly..."
if ! command -v ly &> /dev/null; then
    yay --noconfirm -S --needed ly
    sudo systemctl enable ly.service
else
    echo "Ly is already installed."
fi

# Set up XDG environment variables
echo "Setting up XDG environment variables..."
mkdir -v -p "$HOME/.config/environment.d"
# Set up home directory environment variables (Desktop, Documents, Downloads, Music, Pictures, Videos)
echo "Setting up home directory environment variables..."
echo "XDG_DESKTOP_DIR=$HOME/Desktop" > "$HOME/.config/environment.d/xdg-home.conf"
echo "XDG_DOCUMENTS_DIR=$HOME/Documents" >> "$HOME/.config/environment.d/xdg-home.conf"
echo "XDG_DOWNLOAD_DIR=$HOME/Downloads" >> "$HOME/.config/environment.d/xdg-home.conf"
echo "XDG_MUSIC_DIR=$HOME/Music" >> "$HOME/.config/environment.d/xdg-home.conf"
echo "XDG_PICTURES_DIR=$HOME/Pictures" >> "$HOME/.config/environment.d/xdg-home.conf"
echo "XDG_VIDEOS_DIR=$HOME/Videos" >> "$HOME/.config/environment.d/xdg-home.conf"
# Create necessary directories
SCRIPT_HOME_DIRS=(
    "$HOME/.local/share/applications"
    "$HOME/.config/gtk-3.0"
    "$HOME/.config/gtk-4.0"
    "$HOME/.config"
    "$HOME/.local/share"
    "$HOME/.cache"
    "$HOME/.local/bin"
    "$HOME/Desktop"
    "$HOME/Documents"
    "$HOME/Downloads"
    "$HOME/Music"
    "$HOME/Pictures"
    "$HOME/Videos"
)
for dir in "${SCRIPT_HOME_DIRS[@]}"; do
    mkdir -v -p "$dir"
done

# Install the Rosé Pine GTK theme
echo "Installing Rosé Pine GTK theme..."
ROSE_PINE_PACKAGES=(
    "gtk3"
    "gtk4"
    "rose-pine-icons"
)
ROSE_PINE_VERSION=$(curl -s https://api.github.com/repos/rose-pine/gtk/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
if [[ -z "$ROSE_PINE_VERSION" ]]; then
    echo "Error: Could not determine the latest Rosé Pine GTK version."
    exit 1
fi
RP_GTK_FILES=(
    "gtk3.tar.gz"
    "gtk4.tar.gz"
    "rose-pine-icons.tar.gz"
)
RP_GTK_URL="https://github.com/rose-pine/gtk/releases/download/$ROSE_PINE_VERSION"
for file in "${RP_GTK_FILES[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "Downloading $file..."
        curl -LO "$RP_GTK_URL/$file"
        if [[ $? -ne 0 ]]; then
            echo "Error: Failed to download $file."
            exit 1
        fi
    else
        echo "$file already exists, skipping download."
    fi
done

RP_CURSOR_URL="https://github.com/rose-pine/cursor/releases/download/v1.1.0/BreezeX-RosePine-Linux.tar.xz"
# Download and extract the cursor theme
if [[ ! -f "BreezeX-RosePine-Linux.tar.xz" ]]; then
    echo "Downloading BreezeX-RosePine cursor theme..."
    curl -LO "$RP_CURSOR_URL"
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to download BreezeX-RosePine cursor theme."
        exit 1
    fi
else
    echo "BreezeX-RosePine cursor theme already exists, skipping download."
fi

# Extract the GTK themes
mkdir -p "$HOME/.themes"
tar -xzf "gtk3.tar.gz" -C "$HOME/.themes" --warning=no-unknown-keyword
mkdir -p "$HOME/.config/gtk-4.0"
tar -xzf "gtk4.tar.gz" -C "$HOME/.config/gtk-4.0" --warning=no-unknown-keyword
mv "$HOME/.config/gtk-4.0/gtk4/rose-pine.css" "$HOME/.config/gtk-4.0/gtk.css"
mkdir -p "$HOME/.icons"
tar -xzf "rose-pine-icons.tar.gz" -C "$HOME/.icons" --warning=no-unknown-keyword
tar -xvf "BreezeX-RosePine-Linux.tar.xz" -C ~/.local/share/icons --warning=no-unknown-keyword

# Install fonts
FONT_URLS=(
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/DepartureMono.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IosevkaTermSlab.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/ProggyClean.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip"
)
FONT_PACKAGES=(
    "ttf-dejavu"
    "ttf-ibm-plex"
    "ttf-roboto"
    "ttf-ancient-fonts"
    "ttf-twemoji"
    "noto-fonts-cjk"
)

# Install Starship
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh

# optional packages
echo "Do you want to install optional packages? (y/n)"
read -r INSTALL_ADDITIONAL
if [[ "$INSTALL_ADDITIONAL" == "y" || "$INSTALL_ADDITIONAL" == "Y" ]]; then
    ADDITIONAL_PACKAGES=(
        "equibop-bin"
    )
    yay --noconfirm -S --needed "${ADDITIONAL_PACKAGES[@]}"
else
    echo "Skipping additional packages installation."
fi

# Copy configuration files using rsync (current directory to home directory excluding install.sh and .git)
# only overwriting and creating!!!!!
echo "Copying configuration files..."
rsync -av --exclude='install.sh' --exclude='.git' "$SCRIPT_DIR/dots/" "$HOME/"

# Install cli tools
echo "Installing CLI tools..."
CLI_TOOLS=(
    "bat"
    "fd"
    "fzf"
    "ripgrep"
    "tree-sitter-cli"
    "exa"
    "fastfetch"
    "btop"
    "zoxide"
)
yay --noconfirm -S --needed "${CLI_TOOLS[@]}"

# Prompt the user for their preferred shell
echo "Which shell do you prefer? (bash/zsh/fish)"
read -r SHELL_CHOICE
case "$SHELL_CHOICE" in
    bash)
        echo "Setting up Bash..."

        if ! grep -q "source \$HOME/.config/starship.toml" "$HOME/.bashrc"; then
            echo "source \$HOME/.config/starship.toml" >> "$HOME/.bashrc"
        fi

        if ! grep -q "zoxide init bash" "$HOME/.bashrc"; then
            echo "eval \"\$\(zoxide init --cmd cd bash\)\"" >> "$HOME/.bashrc"
        fi

        if ! grep -q "shell" "$HOME/.config/kitty/kitty.conf"; then
            echo "shell $SHELL_CHOICE" >> "$HOME/.config/kitty/kitty.conf"
        fi
        ;;
    zsh)
        echo "Setting up Zsh..."
        # Install Zsh if not already installed
        if ! command -v zsh &> /dev/null; then
            yay --noconfirm -S --needed zsh
        fi

        # Create Zsh config directory if it doesn't exist
        mkdir -p "$HOME/.config/zsh"

        if ! grep -q "source \$HOME/.config/starship.toml" "$HOME/.zshrc"; then
            echo "source \$HOME/.config/starship.toml" >> "$HOME/.zshrc"
        fi

        if ! grep -q "zoxide init zsh" "$HOME/.zshrc"; then
            echo "eval \"\$\(zoxide init --cmd cd zsh\)\"" >> "$HOME/.zshrc"
        fi

        if ! grep -q "shell" "$HOME/.config/kitty/kitty.conf"; then
            echo "shell $SHELL_CHOICE" >> "$HOME/.config/kitty/kitty.conf"
        fi
        ;;
    fish)
        echo "Setting up Fish..."
        # Install Fish if not already installed
        if ! command -v fish &> /dev/null; then
            yay --noconfirm -S --needed fish
        fi

        if ! grep -q "shell" "$HOME/.config/kitty/kitty.conf"; then
            echo "shell $SHELL_CHOICE" >> "$HOME/.config/kitty/kitty.conf"
        fi
        ;;
    *)
        echo "Unsupported shell: $SHELL_CHOICE. Please set up Starship manually."
        ;;
esac

# Download fonts

# Copy root stuff
#  Ly
sudo cp -rv "$SCRIPT_DIR/root/ly.ini" /etc/ly/config.ini

echo "Installation complete! Do you want to reboot now? (y/N)"
read -r REBOOT_CHOICE
if [[ "$REBOOT_CHOICE" == "y" || "$REBOOT_CHOICE" == "Y" ]]; then
    echo "Rebooting..."
    sudo reboot
else
    echo "You can reboot later to apply changes."
fi
