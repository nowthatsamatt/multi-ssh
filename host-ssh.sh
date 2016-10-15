#!/bin/bash
starttmux() {
  HOSTS='w1.nowthatsamatt.com w2.nowthatsamatt.com'
  local hosts=( $HOSTS )
  tmux new-window "ssh ${hosts[0]}"

  unset hosts[0];

  for i in "${hosts[@]}"; do
    tmux split-window -h  "ssh $i"
    tmux select-layout tiled > /dev/null
  done

  tmux select-pane -t 0
  tmux set-window-option synchronize-panes on > /dev/null
}

HOSTS=${HOSTS:=$*}

starttmux
