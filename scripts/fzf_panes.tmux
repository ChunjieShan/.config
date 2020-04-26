#!/usr/bin/env sh

new_window() {
    [[ -x $(command -v fzf 2>/dev/null) ]] || return
    pane_id=$(tmux show -gqv '@fzf_pane_id')
    [[ -n $pane_id ]] && tmux kill-pane -t $pane_id >/dev/null 2>&1
    tmux new-window "sh $0 do_action" >/dev/null 2>&1
}

update_mru_pane_ids() {
    o_data=($(tmux show -gqv '@mru_pane_ids'))
    current_pane_id=$(tmux display-message -p '#D')
    n_data=($current_pane_id)
    for i in ${!o_data[@]}; do
        [[ $current_pane_id != ${o_data[i]} ]] && n_data+=(${o_data[i]})
    done
    tmux set -g '@mru_pane_ids' "${n_data[*]}"
}

do_action() {
    trap 'tmux set -gu @fzf_pane_id' EXIT SIGINT SIGTERM
    current_pane_id=$(tmux display-message -p '#D')
    tmux set -g @fzf_pane_id $current_pane_id

    cmd="sh $0 panes_src"
    set -- 'tmux capture-pane -pe -S' \
        '$(start=$(( $(tmux display-message -t {1} -p "#{pane_height}")' \
        '- $FZF_PREVIEW_LINES ));' \
        '(( start>0 )) && echo $start || echo 0) -t {1}'
    preview_cmd=$*
    last_pane_cmd='$(tmux show -gqv "@mru_pane_ids" | cut -d\  -f1)'
    selected=$(FZF_DEFAULT_COMMAND=$cmd fzf -m --preview="$preview_cmd" \
        --preview-window='down:80%' --reverse --info=inline --header-lines=1 \
        --delimiter='\s{2,}' --with-nth=2..-1 --nth=1,2,9 \
        --bind="alt-p:toggle-preview" \
        --bind="ctrl-r:reload($cmd)" \
        --bind="ctrl-x:execute-silent(tmux kill-pane -t {1})+reload($cmd)" \
        --bind="ctrl-v:execute(tmux move-pane -h -t $last_pane_cmd -s {1})+accept" \
        --bind="ctrl-s:execute(tmux move-pane -v -t $last_pane_cmd -s {1})+accept" \
        --bind="ctrl-t:execute-silent(tmux swap-pane -t $last_pane_cmd -s {1})+reload($cmd)")
    (($?)) && return

    ids_o=($(tmux show -gqv '@mru_pane_ids'))
    ids=()
    for id in ${ids_o[@]}; do
        while read pane_line; do
            pane_info=($pane_line)
            pane_id=${pane_info[0]}
            [[ $id == $pane_id ]] && ids+=($id)
        done <<<$selected
    done

    id_n=${#ids[@]}
    id1=${ids[0]}
    if ((id_n == 1)); then
        tmux switch-client -t$id1
    elif ((id_n > 1)); then
        tmux break-pane -s$id1
        i=1
        tmux_cmd="tmux "
        while ((i < id_n)); do
            tmux_cmd+="move-pane -t${ids[i-1]} -s${ids[i]} \; select-layout -t$id1 'tiled' \; "
            ((i++))
        done
        tmux_cmd+="switch-client -t$id1 \; select-layout -t$id1 'tiled' \; "
        eval $tmux_cmd
    fi

    tmux set -gu '@fzf_pane_id'
}

panes_src() {
    printf "%-6s  %-7s  %5s  %8s  %4s  %4s  %5s  %-8s  %-7s  %s\n" \
        'PANEID' 'SESSION'  'PANE' 'PID' '%CPU' '%MEM' 'THCNT' 'TIME' 'TTY' 'CMD'
    panes_info=$(tmux list-panes -aF \
        '#D #{=|5|..:session_name} #I.#P #{pane_tty}' |
        sed -E "/^$TMUX_PANE /d")
    ttys=$(awk '{printf("%s,", $4)}'<<<$panes_info | sed 's/,$//')
    ps_info=$(ps -t$ttys -o stat,pid,pcpu,pmem,thcount,time,tname,cmd |
        awk '$1~/\+/ {$1="";print $0}')
    ids=()
    for id in $(tmux show -gqv '@mru_pane_ids'); do
        while read pane_line; do
            pane_info=($pane_line)
            pane_id=${pane_info[0]}
            if [[ $id == $pane_id ]]; then
                ids+=($id)
                session=${pane_info[1]}
                pane=${pane_info[2]}
                tty=${pane_info[3]#/dev/}
                while read ps_line; do
                    p_info=($ps_line)
                    if [[ $tty == ${p_info[5]} ]]; then
                        printf "%-6s  %-7s  %5s  %8s  %4s  %4s  %5s  %-8s  %-7s  " \
                            $pane_id $session $pane ${p_info[@]::6}
                        echo ${p_info[@]:6}
                        break
                    fi
                done <<<$ps_info
            fi
        done <<<$panes_info
    done
    tmux set -g '@mru_pane_ids' "${ids[*]}"
}

$@
