#!/bin/bash

# ZSH Plugins Setup
# This script installs zsh-syntax-highlighting and zsh-autosuggestions

ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_DIR="$HOME/.zsh-plugins"

echo "🔧 Configurando plugins de ZSH..."

# Crear directorio de plugins si no existe
mkdir -p "$PLUGINS_DIR"

# Instalar fzf para búsqueda mejorada en historial
if ! command -v fzf &> /dev/null; then
    echo "📦 Instalando fzf (fuzzy finder)..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install fzf
            # Instalar key bindings manualmente ya que usamos --no-update-rc
            echo "🔧 Configurando key bindings de fzf..."
        else
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install --key-bindings --completion --update-rc
        fi
    else
        # Linux
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --key-bindings --completion --update-rc
    fi
    echo "✅ fzf instalado"
else
    echo "ℹ️ fzf ya está instalado"
    
    # Verificar si fzf está configurado correctamente
    if ! grep -q "fzf" "$HOME/.zshrc" 2>/dev/null; then
        echo "🔧 Configurando fzf existente..."
        if [[ -f ~/.fzf.zsh ]]; then
            echo "source ~/.fzf.zsh" >> "$HOME/.zshrc"
        fi
    fi
fi

# Instalar zsh-syntax-highlighting
if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "📦 Instalando zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"
    echo "✅ zsh-syntax-highlighting instalado"
else
    echo "ℹ️ zsh-syntax-highlighting ya está instalado"
fi

# Instalar zsh-autosuggestions
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    echo "📦 Instalando zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGINS_DIR/zsh-autosuggestions"
    echo "✅ zsh-autosuggestions instalado"
else
    echo "ℹ️ zsh-autosuggestions ya está instalado"
fi

# Configurar .zshrc
ZSHRC="$HOME/.zshrc"

echo "🔧 Configurando .zshrc..."

# Añadir configuración de plugins si no existe
if ! grep -q "# ZSH Plugins Configuration" "$ZSHRC" 2>/dev/null; then
    cat >> "$ZSHRC" << 'EOF'

# ZSH Plugins Configuration
# Cargar autosuggestions
source ~/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Configuración de fzf para búsqueda mejorada en historial
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_R_OPTS='--sort --exact --preview "echo {}" --preview-window down:3:hidden:wrap --bind "?:toggle-preview"'

# Cargar fzf key bindings y completion
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
elif [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
elif [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
fi

# Configuraciones personalizadas
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,underline"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Colores personalizados para syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'

# Keybindings para autosuggestions
bindkey '^ ' autosuggest-accept      # Ctrl+Space para aceptar sugerencia

# zsh-syntax-highlighting (DEBE SER LA ÚLTIMA LÍNEA)
source ~/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
EOF
    echo "✅ Configuración añadida a .zshrc"
else
    echo "ℹ️ Configuración ya existe en .zshrc"
fi

echo "✅ Plugins de ZSH configurados correctamente!"
echo "💡 Funcionalidades añadidas:"
echo "   • Syntax highlighting (comandos en verde/rojo)"
echo "   • Autosugerencias inteligentes (Ctrl+Space para aceptar)"
echo "   • Búsqueda mejorada en historial con fzf (Ctrl+R)"
echo ""
echo "� Para verificar que fzf funciona correctamente:"
echo "   1. Reinicia la terminal o ejecuta: source ~/.zshrc"
echo "   2. Prueba Ctrl+R para buscar en el historial"
echo ""
echo "⚠️  Si Ctrl+R no funciona con fzf, ejecuta:"
echo "   bash zsh/fix-fzf.sh"
