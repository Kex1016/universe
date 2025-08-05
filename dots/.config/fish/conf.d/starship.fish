# check if starship is installed
if command -v starship &> /dev/null;
    starship init fish | source
end
