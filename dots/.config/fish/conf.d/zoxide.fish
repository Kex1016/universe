# check if zoxide is installed
if command -v zoxide &> /dev/null; then
    zoxide init --cmd cd fish | source
end
