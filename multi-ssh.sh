#!/bin/bash
if [ $# -ne 4 ]
then
    echo "Example: multi-ssh.sh (hostname) (region) (1) (10)"
    exit 0
fi

HOSTS=()

for i in $(seq -f "%02g" $3 $4)
do
    HOSTS+=($1${i}.$2)
done

tmux new-window "ssh ${HOSTS[0]}"

unset HOSTS[0];

for i in "${HOSTS[@]}"; do
    tmux split-window -h  "ssh $i"
    tmux select-layout tiled > /dev/null
done

tmux select-pane -t 0
tmux set-window-option synchronize-panes on > /dev/null
