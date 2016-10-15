#!/bin/bash
KEYROOT=$5
KEY=$6

if [ $# -ne 4 ]
then
    echo "Example: root-ssh.sh (hostname) (region) 1 10 /Users/matt.cupples/.ssh webserver"
    exit 0
fi

HOSTS=()

for i in $(seq -f "%02g" $3 $4)
do
    HOSTS+=($1${i}.$2)
done

tmux new-window "ssh -i ${KEYROOT}/${KEY} root@${HOSTS[0]}"

unset HOSTS[0];

for i in "${HOSTS[@]}"; do
    tmux split-window -h  "ssh -i ${KEYOOT}/${KEY} root@$i"
    tmux select-layout tiled > /dev/null
done

tmux select-pane -t 0
tmux set-window-option synchronize-panes on > /dev/null
