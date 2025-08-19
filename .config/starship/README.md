# Instructions for starship

## Starship Zsh Transient Prompt

At the time of writing starship doesn't have support for zsh transient prompt 
so a small workaround is required. Add the following to ``.zshrc``:

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

## Starship "Dynamic" size

!!! IMPORTANT !!!
If you are using this then the config files need to be placed at ``~/.config/starship/```. 
Otherwise, you need to edit the paths so the configs can be loaded by starship. 

As far as I could read from the docs and experiment with, you can't really 
disable built-in modules based on some arbitrary conditions (say $COLUMNS var). 
A workaround that worked for me was having multiple config files and changing 
the current config in ``.zshrc``. Add the following before loading starship:

```zsh

## Starship "Dynamic" Module Workaround

starship_precmd() {
  if [ "$COLUMNS" -lt 30 ]; then
    export STARSHIP_CONFIG="$HOME/.config/starship/tiny_starship.toml"
  elif [ "$COLUMNS" -lt 50 ]; then
    export STARSHIP_CONFIG="$HOME/.config/starship/small_starship.toml"
  elif [ "$COLUMNS" -lt 100 ]; then
    export STARSHIP_CONFIG="$HOME/.config/starship/medium_starship.toml"
  else
    export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  fi
}

```
