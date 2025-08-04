git pull
echo "Copying configuration files..."
rsync -av --exclude='install.sh' --exclude='.git' --exclude='README.md' "$SCRIPT_DIR/" "$HOME/"

echo "Installation complete! Do you want to reboot now? (y/N)"
read -r REBOOT_CHOICE
if [[ "$REBOOT_CHOICE" == "y" || "$REBOOT_CHOICE" == "Y" ]]; then
    echo "Rebooting..."
    sudo reboot
else
    echo "You can reboot later to apply changes."
fi
