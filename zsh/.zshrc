source "$HOME/.cargo/env"

# bun completions
[ -s "/Users/ricardoceia/.bun/_bun" ] && source "/Users/ricardoceia/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<


# Added by Antigravity CLI installer
export PATH="/Users/ricardoceia/.local/bin:$PATH"

# Simple Catppuccin Mocha prompt: teal user@host, green dir, pink %
PROMPT='%F{#94e2d5}%n@%m%f %F{#a6e3a1}%1~%f %F{#f5c2e7}%#%f '
