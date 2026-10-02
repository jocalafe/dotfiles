export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
elif command -v brew >/dev/null 2>&1; then
  NVM_BREW_PREFIX="$(brew --prefix nvm 2>/dev/null)"
  if [[ -s "$NVM_BREW_PREFIX/nvm.sh" ]]; then
    source "$NVM_BREW_PREFIX/nvm.sh"
    [[ -s "$NVM_BREW_PREFIX/etc/bash_completion.d/nvm" ]] && source "$NVM_BREW_PREFIX/etc/bash_completion.d/nvm"
  fi
fi

if command -v nvm >/dev/null 2>&1; then
  autoload -U add-zsh-hook
  load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [[ -n "$nvmrc_path" ]]; then
      local nvmrc_node_version="$(nvm version "$(cat "$nvmrc_path")")"
      if [[ "$nvmrc_node_version" == "N/A" ]]; then
        nvm install
      elif [[ "$nvmrc_node_version" != "$node_version" ]]; then
        nvm use
      fi
    else
      local default_node_version="$(nvm version default)"
      if [[ "$default_node_version" != "N/A" && "$node_version" != "$default_node_version" ]]; then
        echo "Reverting to nvm default version"
        nvm use default
      fi
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
if [[ -s "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

source "$HOME/.aliases"

export NVIM_LOG_FILE_PATH="$HOME/.vim-runtime/"
export BAT_THEME="gruvbox-dark"
export VISUAL=nvim

if command -v rbenv >/dev/null 2>&1; then eval "$(rbenv init -)"; fi
if command -v zoxide >/dev/null 2>&1; then eval "$(zoxide init zsh)"; fi

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

export PNPM_HOME="$HOME/Library/pnpm"
[[ -d "$PNPM_HOME" ]] && export PATH="$PNPM_HOME:$PATH"

export BUN_INSTALL="$HOME/.bun"
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"
[[ -d "$BUN_INSTALL/bin" ]] && export PATH="$BUN_INSTALL/bin:$PATH"

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
CORRETTO_BIN="$HOME/Library/Java/amazon-corretto-21.jdk/Contents/Home/bin"
[[ -d "$CORRETTO_BIN" ]] && export PATH="$CORRETTO_BIN:$PATH"
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"
[[ -d "$HOME/.codeium/windsurf/bin" ]] && export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# Warp shell integration; harmless in other terminals.
printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh", "uname": "Darwin" }}\e\\'
