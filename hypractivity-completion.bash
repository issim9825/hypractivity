#!/bin/bash

# ==============================================================================
# HYPR-ACTIVITY BASH COMPLETION
# ==============================================================================
# Save this file to /usr/share/bash-completion/completions/hypr-activity
# Or source it in your ~/.bashrc
# ==============================================================================

#!/bin/bash

_hypractivity_completions() {
    local cur prev first_cmd
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # The subcommand is always the first word after the script name
    first_cmd="${COMP_WORDS[1]}"
    
    # Primary Subcommands
    local opts="next prev switch rename list info delete"

    # State file path (Must match your main script)
    local LIST_FILE="$HOME/.cache/hypr-activities/list"

    # 1. Complete the subcommand if we are at the first position
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
        return 0
    fi

    # 2. Complete the activity name(s) for specific subcommands
    # This now handles any number of arguments (COMP_CWORD >= 2)
    case "$first_cmd" in
        switch|rename|info|delete)
            if [[ -f "$LIST_FILE" ]]; then
                # Fetch all activities from the list file
                local all_activities=$(cat "$LIST_FILE")
                
                # OPTIONAL: Filter out activities already present on the command line
                # This prevents suggesting 'work' if you already typed it.
                local suggestions=""
                for act in $all_activities; do
                    if [[ ! " ${COMP_WORDS[@]:2} " =~ " $act " ]] || [[ "$act" == "$cur" ]]; then
                        suggestions+="$act "
                    fi
                done

                COMPREPLY=( $(compgen -W "$suggestions" -- "$cur") )
            fi
            return 0
            ;;
    esac
}

complete -F _hypractivity_completions hypractivity