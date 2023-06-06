#!/bin/env/zsh

load_tmux ()
 {
    if [ -n "${TMUX+1}" ] || ! type tmux >/dev/null 2>&1; then
        return;
    fi
 
    if ! tmux has-session -t=$1 >/dev/null 2>&1; then
        exec tmux new-session -s $1;
    fi
 
    if [ -z "$(tmux list-clients -t=$1)" ]; then
        exec tmux attach -t=$1;
    fi
}
 
load_tmux "Z"
