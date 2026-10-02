if command -v brew >/dev/null 2>&1; then
  FZF_PREFIX="$(brew --prefix fzf 2>/dev/null)"
  if [[ -n "$FZF_PREFIX" ]]; then
    case ":$PATH:" in
      *":$FZF_PREFIX/bin:"*) ;;
      *) export PATH="$FZF_PREFIX/bin:$PATH" ;;
    esac

    if [[ -o interactive ]]; then
      if (( $+functions[compdef] )) && [[ -r "$FZF_PREFIX/shell/completion.zsh" ]]; then
        source "$FZF_PREFIX/shell/completion.zsh"
      fi
      [[ -r "$FZF_PREFIX/shell/key-bindings.zsh" ]] && source "$FZF_PREFIX/shell/key-bindings.zsh"
    fi
  fi
fi
