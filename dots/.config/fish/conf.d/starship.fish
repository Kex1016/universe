# check if starship is installed
if command -v starship &> /dev/null; then
    starship init fish | source
fi
