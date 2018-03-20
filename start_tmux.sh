session_exists() {
  tmux has-session -t "$1" 2>/dev/null
}
if session_exists "work"
then

    tmux attach -t work
else
    tmux new-session -s work -n editor -d
    tmux split-window -v -p 15 -t work:0.0
    tmux new-window -n console -t work
    tmux select-window -t work:0
    tmux select-pane -t work:0.0
    #tmux send-keys -t development 'cd ~/devproject' C-m
    tmux attach -t work
fi
