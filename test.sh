mkdir -p "$HOME/.themes"
tar -xzf "gtk3.tar.gz" -C "$HOME/.themes" --warning=no-unknown-keyword
mv "$HOME/.themes/gtk3/rose-pine-gtk" "$HOME/.themes"
# rm -rf "$HOME/.themes/gtk3"
mkdir -p "$HOME/.config/gtk-4.0"
tar -xzf "gtk4.tar.gz" -C "$HOME/.config/gtk-4.0" --warning=no-unknown-keyword
mv "$HOME/.config/gtk-4.0/gtk4/rose-pine.css" "$HOME/.config/gtk-4.0/gtk.css"
mkdir -p "$HOME/.icons"
tar -xzf "rose-pine-icons.tar.gz" -C "$HOME/.icons" --warning=no-unknown-keyword
mv "$HOME/.icons/icons/rose-pine-icons" "$HOME/.icons/"
# rm -rf "$HOME/.icons/icons"
tar -xvf "BreezeX-RosePine-Linux.tar.xz" -C ~/.local/share/icons --warning=no-unknown-keyword
