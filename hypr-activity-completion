#!/bin/bash

# ==============================================================================
# HYPR-ACTIVITY BASH COMPLETION
# ==============================================================================
# Save this file to /usr/share/bash-completion/completions/hypr-activity
# Or source it in your ~/.bashrc
# ==============================================================================

_hypr_activity_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # Primary Subcommands
    opts="next prev switch list info delete"

    # State file path
    local LIST_FILE="$HOME/.cache/hypr-activities/list"

    # If completing the first argument (the subcommand)
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
        return 0
    fi

    # If completing the second argument (the activity name)
    if [[ ${COMP_CWORD} -eq 2 ]]; then
        case "$prev" in
            switch|info|delete)
                if [[ -f "$LIST_FILE" ]]; then
                    local activities=$(cat "$LIST_FILE" 2>/dev/null)
                    COMPREPLY=( $(compgen -W "$activities" -- "$cur") )
                fi
                return 0
                ;;
        esac
    fi
}

# Apply completion to both the script name and the likely alias
complete -F _hypr_activity_completions hypr-activity

