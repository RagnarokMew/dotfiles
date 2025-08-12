# Instructions for starship

At the time of writing starship doesn't have support for zsh transient prompt 
so a small workaround is required

```zsh

## Transient Prompt Workaround

autoload -Uz add-zsh-hook add-zle-hook-widget

# Starship transient prompt profile
TRANSIENT_PROMPT='$(starship prompt --status=$TRANSIENT_STATUS --profile transient)'
TRANSIENT_RPROMPT='$(starship prompt --profile rtransient)'

# Save original prompts
ORIGINAL_PROMPT="$PROMPT"
ORIGINAL_RPROMPT="$RPROMPT"

typeset -g TRANSIENT_STATUS=0

function transient-prompt-precmd {
    TRANSIENT_STATUS=$?
    # Restore the original prompt first
    PROMPT="$ORIGINAL_PROMPT"
    RPROMPT="$ORIGINAL_RPROMPT"

    # Fix Ctrl+C behavior
    TRAPINT() {
	TRANSIENT_STATUS=130
        zle && { transient-prompt; return $(( 128 + $1 )) }
        return 0
    }
}

function transient-prompt {
    # Set the transient prompt
    PROMPT="$TRANSIENT_PROMPT"
    RPROMPT="$TRANSIENT_RPROMPT"

    # Redraw the prompt
    zle && zle .reset-prompt
}

function zle-prompt-line-finish {
    transient-prompt
    zle .accept-line
}
zle -N transient-prompt-line-finish

# Set up hooks
add-zsh-hook precmd transient-prompt-precmd
add-zle-hook-widget line-finish zle-prompt-line-finish

```
