[[ -t 0 ]] && stty -echo

# ─── Environment ──────────────────────────────────────────────
export HOMEBREW_NO_ENV_HINTS=true
export PATH="$HOME/.local/bin:$PATH"
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1

# ─── Setup ────────────────────────────────────────────────────
# Install all tools used by this config
brew-install-all() {
    brew install starship zoxide neovim eza bat git fzf
    brew install --cask visual-studio-code
}

# brew i -> brew install
if command -v brew &> /dev/null; then
    brew alias i &> /dev/null || brew alias i=install
fi

# ─── Tool initialization ──────────────────────────────────────
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

if command -v thefuck &> /dev/null; then
    eval "$(thefuck --alias)"
fi

# ─── Aliases ──────────────────────────────────────────────────
alias cls="clear"
alias qq="exit"
alias cldyl="tmux new 'CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --teammate-mode tmux --model opus --dangerously-skip-permissions'"

if command -v code &> /dev/null; then
    alias c="code"
fi

if command -v nvim &> /dev/null; then
    alias vim="nvim"
fi

if command -v eza &> /dev/null; then
    alias l="eza"
    alias ll="eza -a"
    alias lll="eza -al"
fi

if command -v bat &> /dev/null; then
    alias cat="bat"
    alias catp="bat -p"
fi

# git
if command -v git &> /dev/null; then
    alias gs="git status"        # status
    alias ga="git add"           # add
    alias gc="git commit -m"     # commit
    alias gco="git checkout"     # checkout
    alias gb="git branch"        # branch
    alias gl="git log"           # log
    alias gd="git diff"          # diff

    alias gpull="git pull"       # pull
    alias gpush="git push"       # push

    alias grem="git remote -v"   # list remotes
    alias gremadd="git remote add"  # add remote

    alias ginit="git init"       # init

    # ss <branch>: stash -> switch branch -> stash pop
    if ! git config --global --get alias.ss &> /dev/null; then
        git config --global alias.ss '!f() { git stash push && git switch "$1" && git stash pop; }; f'
    fi
fi

# ─── Completion ───────────────────────────────────────────────
# Auto completion ignore case
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ─── fzf ──────────────────────────────────────────────────────
if command -v fzf &> /dev/null; then
    source <(fzf --zsh)

    # Make fuzzyfind with history
    HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    setopt appendhistory

    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

alias reload="source ~/.zshrc"

[[ -t 0 ]] && stty echo

# Added by Antigravity IDE
export PATH="/Users/phuripatk/.antigravity-ide/antigravity-ide/bin:$PATH"

# AsyncAPI CLI Autocomplete

ASYNCAPI_AC_ZSH_SETUP_PATH=/Users/phuripatk/Library/Caches/@asyncapi/cli/autocomplete/zsh_setup && test -f $ASYNCAPI_AC_ZSH_SETUP_PATH && source $ASYNCAPI_AC_ZSH_SETUP_PATH; # asyncapi autocomplete setup




# Added by Antigravity CLI installer
export PATH="/Users/phuripatk/.local/bin:$PATH"

# global alias: cmd grp pattern -> cmd | grep pattern
alias -g grp='| grep'

# Source - https://stackoverflow.com/a/7060716
# Posted by ches, modified by community. See post 'Timeline' for change history

# Retrieved 2026-07-07, License - CC BY-SA 4.0

# Remove the default of run-help being aliased to man
unalias run-help 2>/dev/null
# Use zsh's run-help, which will display information for zsh builtins.
autoload run-help

# zoxide
# init is already last in this file; the doctor warning is triggered by the
# deliberate `alias cd='z'` below, so silence it.
export _ZO_DOCTOR=0
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# pnpm
export PNPM_HOME="/Users/phuripatk/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
export PATH=/opt/homebrew/opt/openjdk@25/bin:$PATH
