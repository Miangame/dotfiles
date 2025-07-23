#!/bin/bash

TARGET="$HOME/.custom_aliases"

echo "🚀 Iniciando instalación de dotfiles..."
echo ""

# Verificar si estamos usando ZSH e instalar Oh My Zsh si es necesario
if [[ $SHELL == *zsh ]]; then
  echo "🔍 Detectado ZSH, verificando Oh My Zsh..."
  
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "✅ Oh My Zsh instalado correctamente"
  else
    echo "ℹ️ Oh My Zsh ya está instalado"
  fi
  echo ""
fi

# Instalar aliases
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

# Instalar plugins de ZSH si estamos usando ZSH
if [[ $SHELL == *zsh ]]; then
  echo ""
  echo "🔧 Instalando plugins adicionales de ZSH..."
  
  # Descargar el script de configuración de zsh si no existe localmente
  if [ ! -f "zsh/setup.sh" ]; then
    echo "📥 Descargando configuración de ZSH..."
    curl -s https://raw.githubusercontent.com/Miangame/dotfiles/main/zsh/setup.sh | bash
  else
    bash zsh/setup.sh
  fi
fi

echo ""
echo "✅ Instalación completada!"
echo "💡 Reinicia la terminal o ejecuta:"
echo "   source $TARGET"
if [[ $SHELL == *zsh ]]; then
  echo "   source ~/.zshrc"
fi
