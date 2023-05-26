echo "BASH"
COMMAND="bash"
FILES=("bashrc" "bash_aliases" "profile")
DLINK=("$HOME/.bashrc" "$HOME/.bash_aliases" "$HOME/.profile")

# Install package 

echo "     * Installling packages $COMMAND"
sudo apt install bash -y &> /dev/null
# Set bash as default shell
sudo chsh -s /usr/bin/bash $USER
echo "     * Setting default shell to BASH"
