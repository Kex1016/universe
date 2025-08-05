# npm global packages
set -gx NPM_CONFIG_PREFIX "$HOME/.npm-global"

# PATH
# user scripts
fish_add_path "$HOME/.local/bin"
# npm
fish_add_path "$HOME/.npm-global/bin"
