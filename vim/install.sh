echo "VIM"
COMMAND="vim"
FILES=('vimrc' 'viminfo' '')
DLINK=('/tmp/.vimrc' '/tmp/.viminfo' '/tmp/.vim')

sudo apt install vim-nox > /dev/null 2&>1
