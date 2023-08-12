#!/bin/bash

# Script para configurar as opções do Termux

# Cores ANSI
vermelho="\033[1;31m"
verde="\033[1;32m"
reset="\033[0m"

# Função para fazer backup de um arquivo
fazer_backup() {
    if [ -e "$1" ]; then
        cp "$1" "$1.bkp"
        echo -e "${vermelho}Backup de $1 criado como $1.bkp${reset}"
    fi
}

# Função para baixar e aplicar uma configuração
baixar_e_aplicar() {
    URL="$1"
    ARQUIVO="$2"
    PASTA_DESTINO="$3"
    
    fazer_backup "$PASTA_DESTINO/$ARQUIVO"
    
    curl -sLo "$PASTA_DESTINO/$ARQUIVO" "$URL"
    echo -e "${verde}Configuração $ARQUIVO aplicada${reset}"
}

echo -e "${verde}Iniciando configurações do Termux...${reset}"

# URL para bash.bashrc (URL original)
URL_BASH_BASHRC="https://raw.githubusercontent.com/SnowPerfectDev/Termux-Config-Setup/main/prompt-settings/bash-configs/bash.bashrc"
# URL para termux.properties
URL_TERMUX_PROPERTIES="https://raw.githubusercontent.com/SnowPerfectDev/Termux-Config-Setup/main/prompt-settings/termux-configs/termux.properties"
# URL para .nanorc
URL_NANORC="https://raw.githubusercontent.com/SnowPerfectDev/Termux-Config-Setup/main/shell-config/config-files/.nanorc"
# URL para .bashrc (URL principal do repositório)
URL_BASHRC="https://raw.githubusercontent.com/SnowPerfectDev/Termux-Config-Setup/main/prompt-settings/bash-configs/.bashrc"

# Baixa e aplica a configuração do arquivo bash.bashrc
baixar_e_aplicar "$URL_BASH_BASHRC" "bash.bashrc" "/data/data/com.termux/files/usr/etc"
# Baixa e aplica a configuração do arquivo termux.properties
mkdir -p "$HOME/.termux"
baixar_e_aplicar "$URL_TERMUX_PROPERTIES" "termux.properties" "$HOME/.termux"
# Baixa e aplica a configuração do arquivo .nanorc
baixar_e_aplicar "$URL_NANORC" ".nanorc" "$HOME"
# Baixa e aplica o arquivo .bashrc
baixar_e_aplicar "$URL_BASHRC" ".bashrc" "$HOME"

# Copia o script para a pasta /data/data/com.termux/files/usr/bin/
cp "$0" "/data/data/com.termux/files/usr/bin/update-termux-config"
chmod +x "/data/data/com.termux/files/usr/bin/update-termux-config"

echo -e "${verde}Configurações concluídas!${reset}"
