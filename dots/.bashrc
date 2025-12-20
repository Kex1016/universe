export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
gpgconf --launch gpg-agent
$PATH="$PATH:$HOME/.bun/bin"