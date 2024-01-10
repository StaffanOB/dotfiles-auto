echo "TMUX" 
COMMAND="tmux"
FILES=("tmux.conf")
DLINK=("$HOME/.tmux.conf")

sudo apt install tmux &> /dev/null 
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &> /dev/null 
tmux source ~/.tmux.conf &> /dev/null 
