#!/bin/bash

# Script para configurar fzf manualmente si no funciona el Ctrl+R

echo "🔧 Configurando fzf manualmente..."

# Buscar y añadir fzf configuration
ZSHRC="$HOME/.zshrc"

# Eliminar configuraciones anteriores de fzf si existen
if grep -q "source.*fzf" "$ZSHRC" 2>/dev/null; then
    echo "🧹 Limpiando configuración anterior de fzf..."
    grep -v "source.*fzf" "$ZSHRC" > "$ZSHRC.tmp" && mv "$ZSHRC.tmp" "$ZSHRC"
fi

echo "📝 Añadiendo configuración de fzf..."

cat >> "$ZSHRC" << 'EOF'

# FZF Configuration
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_R_OPTS='--reverse --tac --exact --preview "echo {}" --preview-window down:3:hidden:wrap --bind "?:toggle-preview"'

# Cargar fzf key bindings
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
elif [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
elif [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# Si nada anterior funciona, configurar manualmente
if ! typeset -f __fzf_history__ &>/dev/null; then
    # Definir función manual para Ctrl+R
    __fzf_history__() {
        local selected
        selected=$(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]*/, "", cmd); if (!seen[cmd]++) print $0 }' | fzf --reverse --tac --no-sort --height=40% --query="$LBUFFER" --expect=ctrl-r)
        local ret=$?
        if [ -n "$selected" ]; then
            local num=$(echo "$selected" | head -1)
            if [ "$num" = "ctrl-r" ]; then
                selected=$(echo "$selected" | tail -1)
            fi
            selected=$(echo "$selected" | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]*/, "", cmd); print cmd }')
            LBUFFER="$selected"
        fi
        zle redisplay
        return $ret
    }
    zle -N __fzf_history__
    bindkey '^R' __fzf_history__
fi
EOF

echo "✅ Configuración de fzf añadida"
echo "💡 Reinicia la terminal o ejecuta: source ~/.zshrc"
echo "🔍 Después prueba Ctrl+R para ver la búsqueda mejorada"
