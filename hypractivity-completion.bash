#!/bin/bash

# ==============================================================================
# HYPR-ACTIVITY BASH COMPLETION
# ==============================================================================
# Save this file to /usr/share/bash-completion/completions/hypr-activity
# Or source it in your ~/.bashrc
# ==============================================================================

_hypractivity_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # Primary Subcommands
    opts="next prev switch rename list info delete"

    # State file path (Must match your main script)
    local LIST_FILE="$HOME/.cache/hypr-activities/list"

    # 1. Complete the subcommand
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
        return 0
    fi

    # 2. Complete the activity name for specific subcommands
    if [[ ${COMP_CWORD} -eq 2 ]]; then
        case "$prev" in
            switch|rename|info|delete)
                if [[ -f "$LIST_FILE" ]]; then
                    # Read the list file into an array to handle potential spaces/newlines
                    local activities=$(cat "$LIST_FILE")
                    COMPREPLY=( $(compgen -W "$activities" -- "$cur") )
                fi
                return 0
                ;;
        esac
    fi
}

complete -F _hypractivity_completions hypractivity

