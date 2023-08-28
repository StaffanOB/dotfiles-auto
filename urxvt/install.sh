echo "URXVT"
COMMAND="urxvt"
FILES=("urxvt")
DLINK=("$HOME/.urxvt")


sudo apt install rxvt-unicode &> /dev/null
sudo apt install xsel &> /dev/null

if test -f "$HOME/.Xresources"; then
        echo "File exists."
else
    echo "     * Creating Xresources file"
    cp ${DOTD}/${COMMAND}/xresources.config $HOME/.Xresources
fi
