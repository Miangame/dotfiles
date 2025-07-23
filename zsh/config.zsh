# ZSH Custom Configuration
# Configuraciones adicionales para mejorar la experiencia con los plugins

# Configuración de zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,underline"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Configuración de zsh-syntax-highlighting
# Colores personalizados
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=cyan,bold,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'

# Keybindings para autosuggestions
bindkey '^ ' autosuggest-accept      # Ctrl+Space para aceptar sugerencia
bindkey '^[[C' forward-char          # Flecha derecha para aceptar un carácter
