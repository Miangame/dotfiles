#!/bin/bash

TARGET="$HOME/.custom_aliases"

echo "📦 Instalando aliases..."


cat aliases/*.sh > "$TARGET"

if [[ $SHELL == *zsh ]]; then
  SHELL_RC="$HOME/.zshrc"
else
  SHELL_RC="$HOME/.bashrc"
fi

if ! grep -Fxq "source ~/.custom_aliases" "$SHELL_RC"; then
  echo "source ~/.custom_aliases" >> "$SHELL_RC"
  echo "✅ Añadido 'source ~/.custom_aliases' a $SHELL_RC"
else
  echo "ℹ️ Ya estaba añadido en $SHELL_RC"
fi

echo "✅ Instalación completada. Reinicia la terminal o ejecuta: source $TARGET"
