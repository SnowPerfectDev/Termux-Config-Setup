# ********************************************* 
 # * local: ${HOME}/.bashrc * 
 # * SnowPerfectDev
 # * Última modificação: Sexta-feira, 15 de dezembro 08:41:17 - 2023
 #----------------------------------------------- 
 # Configurações Gerais 
 #-----------------------------------------------  
 
 ################# Aliases #################
 
 ###### Configurações de Terminal ######
# Habilita checkwinsize
shopt -s checkwinsize
# **
# Configuração do histórico de comandos
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups
 
############# Comandos Básicos
alias ls='ls --color=auto'
alias ll='ls -alF'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias top='top -o %CPU'
alias h='history'
alias c='clear'
alias e='exit'
alias s='sudo'

############# Gerenciamento de Arquivos e Diretórios
alias lists='nano /etc/apt/sources.list'
alias tt='clear;termux-reload-settings && source ../usr/etc/bash.bashrc'
alias ttsu='clear; tsu'
alias ports='netstat -tuln'
alias mem='ps aux --sort -rss'
alias update='sudo apt update && sudo apt upgrade'
alias upgrade='sudo apt update && sudo apt upgrade'
alias updatezsh='source ~/.zshrc'
alias cdd='cd ~/Downloads'
alias cdm='cd ~/Music'
alias cdp='cd ~/Pictures'
alias cdd='cd ~/Documents'
alias cdw='cd ~/Workspace'
alias cdt='cd ~/Termux'
alias cds='cd ~/Scripts'
alias vi='vim'
alias updatepkg='pkg update && pkg upgrade'
alias rmrf='rm -rf'
alias mkdir='mkdir -p'

############# Navegação Rápida em Diretórios
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

############# Outros Utilitários
alias n='nano'
alias py='python'
alias py3='python3'
alias ip='curl ifconfig.me'
alias listen='nc -lvp'
alias myip='ip addr show wlan0 | grep inet | awk '\''{ print $2; }'\'''
alias cpuinfo='cat /proc/cpuinfo'
alias meminfo='cat /proc/meminfo'
alias diskinfo='df -h'
alias lsa='ls -a'

############# Ferramentas de Rede e Informações
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
alias calc='bc -l'
alias randpass='openssl rand -base64 12'
alias asciiart='curl http://artii.herokuapp.com/make\?text\=Termux'
alias diskusage='ncdu'
alias weather='curl wttr.in'
alias movieinfo='mediainfo'

############# Calendário e Timestamps
alias cal='cal -3'
alias timestamp='date +%s'

############# Criptografia e Segurança
alias encrypt='gpg -c'
alias decrypt='gpg -d'
alias cve='searchsploit'

############# Informações de Rede
alias whatismyip='curl ifconfig.me'
alias iptablesflush='iptables -F'

############# Comandos de Sistema
alias rebootsys='sudo reboot'
alias poweroffsys='sudo poweroff'
alias encryptfile='openssl aes-256-cbc -a -salt -in'
alias decryptfile='openssl aes-256-cbc -d -a -in'
alias qr='qrcode-terminal'

############# Cronômetros e Temporizadores
alias stopwatch='date && time read -sn 1 && echo && date'
alias timer='read -p "Enter the time in seconds: " secs && echo "Timer started for $secs seconds." && sleep $secs && notify-send "Timer finished!"'

############# Testes de Rede
alias speedtest-cli='speedtest-cli --simple'
alias wifi='termux-wifi-connectioninfo'
alias battery='termux-battery-status'
alias shareterm='sshd'

############# Git e Controle de Versão
alias gitinit='git init'
alias gita='git add .'
alias gitc='git commit -m'
alias gitp='git push'
alias gitlog='git log'
alias gitconf='git config --global user.name "Your Name" && git config --global user.email "youremail@example.com"'

############# Saída do Terminal para Termbin
alias tb="nc termbin.com 9999"

############# Testes de Conexão com Ping
alias google='ping -t 3 www.google.com.br' # Ping ao Google a cada 3 segundos
alias uol='ping -t 3 www.uol.com.br' # Ping ao UOL a cada 3 segundos

############# History search helper 
# History search helper
# usage: his query1 query2 queryn...
# example: his ssh 192 (search all ssh commands done to ips inclusing 192)
# example: his sed jsx react (search all sed commands that include "jsx" and "react")
function his() {
  # Store the full history in a variable
  # Command order: history, remove line numbers, remove leading and trailing whitespace, sort, remove duplicates
  # Note that we are using a naive way of removing the line numbers
  commandlog=$(history | grep -oE "[a-zA-Z]{1}.*" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | sort | uniq)

  # For every parameter provided to this function, run a case insensitive grep
  for var in "$@";do
    commandlog=$(echo "$commandlog" | grep -i "$var")
  done

  # Log out the results
  echo "$commandlog"
}


############# Functions list

# Get country / location information of an IP address 
function @ip-locator { 
    local USAGE="usage: ip-locator <ip> [<ip>..]" 
    [ "$1" == "-h" ] && (>&2 echo $USAGE) && return 
    curl ipinfo.io/$1 && shift 
    while [ "$1" != "" ]; do 
        curl ipinfo.io/$1 
        shift 
    done 
} 

# Get domain IP address 
# Requires dig command. To install: sudo apt install dnsutils 
function @ip-resolver() { 
    local USAGE="usage: ip-resolver <domain-name> [<domain-name>..]" 
    [ "$1" == "-h" ] && (>&2 echo $USAGE) && return 
    [ $# -eq 0 ] && (>&2 echo $USAGE) && return 
    while [ "$1" != "" ]; do 
        echo "$1 " ; dig +short @resolver1.opendns.com $1 ; shift 
    done 
} 

# Validate JSON file(s) 
# usage: jsv <file.json> [<file.json>..] 
function jsv() { 
    local USAGE="usage: jsv <file.json> [<file.json>..]" 
    [ -z "$1" ] && (>&2 echo $USAGE) && return 
    [ "$1" == "-h" ] && (>&2 echo $USAGE) && return 
    command -v python3 >/dev/null 2>&1 || { echo >&2 "Missing python3 command"; return; } 
    while [ "$1" != "" ]; do 
        echo -n "$1: " 
        cat $1 | python3 -m json.tool >/dev/null && echo "OK" 
        shift 
    done 
} 

############# Converte nomes de arquivos em letras maiúsculas para minúsculas. 
# uso: lcfile <arquivo> [<arquivo>..] 
function lcfile() { 
    local USAGE="usage: lcfile <file> [<file>..]" 

    [ "$1" = "" ] && (>&2 echo $USAGE) && return 
    [ "$1" = "-h" ] && (>&2 echo $USAGE) && return 
    [ "$1" = "--help" ] && (>&2 echo $USAGE) && return 

    while [ "$1" != "" ]; do 
        if [ -e "$1" ]; then 
            local DST=$(dirname "$1")/$(basename "$1" | tr '[A-Z]' '[a-z]') 
            [ ! -e "${DST}" ] && mv -T "$1" "${DST}" || (>&2 echo "rename fail: $1") 
        else 
            (>&2 echo "invalid file: $1") 
        fi 
        shift 
    done 
} 

############# Substitui substring nos nomes dos arquivos 
# uso: rsfile <search-str> <replace> <file> [<file>..] 
function rsfile() { 
    local USAGE="usage: rsfile <search-str> <replace-str> <file> [<file>..]" 
    local sstr="" 
    local rstr="" 

    while [ "${rstr}" == "" ]; do 
        [ "$1" = "" ] && (>&2 echo $USAGE) && return 
        [ "$1" = "-h" ] && (>&2 echo $USAGE) && return 
        [ "$1" = "--help" ] && (>&2 echo $USAGE) && return 
        if [ "${sstr}" == "" ]; then 
            sstr="$1" 
        else 
            rstr="$1" 
        fi 
        shift 
    done 

    while [ "$1" != "" ]; do 
        if [ -e "$1" ]; then 
            local FNAME=$(basename "$1") 
            local DST=$(dirname "$1")/${FNAME/${sstr}/${rstr}} 
            [ ! -e "${DST}" ] && mv -T "$1" "${DST}" || (>&2 echo "rename fail: $1") 
        else 
            (>&2 echo "invalid file: $1") 
        fi 
        shift 
    done 
} 

#############  Remove non ascii chars (usable for log cleaning) 
# usage: ascify <file> [<file> ..] 
function ascify() { 
    local USAGE="usage: ascify <file> [<file> ..]" 
    [ -z "$1" ] && (>&2 echo $USAGE) && return 
    [ "$1" == "-h" ] && (>&2 echo $USAGE) && return 
    while [ "$1" != "" ]; do 
        tr -cd '\11\12\15\40-\176' <$1 
        shift 
    done 
} 

############# Trim trailing whitespace 
# usage: trim-ws <file> [<file> ..] 
function trim-ws() { 
    local USAGE="usage: trim-ws <file> [<file> ..]" 
    [ -z "$1" ] && (>&2 echo $USAGE) && return 
    [ "$1" == "-h" ] && (>&2 echo $USAGE) && return 
    sed -i 's/[ \t]*$//' $@ 
} 

############ Replace tabs with spaces 
# usage: trim-tab <file> [<file> ..] 
function trim-tab() { 
    local USAGE="usage: trim-tab <file> [<file> ..]" 
    [ -z "$1" ] && (>&2 echo $USAGE) && return 
    [ "$1" == "-h" ] && (>&2 echo $USAGE) && return 
    command -v sponge >/dev/null 2>&1 || { echo >&2 "Missing sponge. Install moreutils"; return; } 
    while [ "$1" != "" ]; do 
        expand -t 4 "$1" | sponge "$1" 
        shift 
    done 
}

############# Script copied from book: 97 Things Every Programmer Should Know 
# Cunningham’s signature analysis: http://www.c2.com/doc/SignatureSurvey/ 
# usage: code-analysis <file> [<file> ..] 
function code-analysis { 
    for i in $@; do 
        echo -n "$i: " 
        sed 's/[^"{};]//g' $i | tr -d '\n' 
        echo 
    done 
} 

############# Generate a random password 
# usage: genpasswd [length] 
function genpasswd() { 
    local PWDLEN=${1:-32} 
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${PWDLEN} | xargs 
} 

############ Generate a PIN code 
# usage: genpin [length] 
function genpin() { 
    local PINLEN=${1:-4} 
    tr -dc 0-9 < /dev/urandom | head -c ${PINLEN} | xargs 
} 

############# Ceasar cipher / ROT-13 
# usage: rot13 [filename] 
function rot13() { 
    if [  $# = 0 ]; then 
        tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" 
    else 
        tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" < $1 
    fi 
} 

############# Show threads of a process 
function atop() { 
    [ -z "$1" ] && (>&2 echo "usage: atop <process-name>") && return 
    top -H -p $(pgrep $1) 
} 

############# List of most used commands in history 
#### NB! If ignoredups and erasedups is used then the output may not be usefull 
# usage: xtop [number] 
function xtop() { 
    local N=${1:-10} 
    history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head -n $N; 
} 

############# # Find all c and cpp src files in dir 
# usage: c-src [dir] 
function c-src() { 
    local USAGE="usage: c-src [dir]" 
    [ "$1" == "-h" ] && (>&2 echo $USAGE) && return 
    local SRC=. 
    [ -n "$1" ] && local SRC="$1" 
    find ${SRC} -regextype posix-extended -regex "^.*\.(cpp|hpp|c|h)$" | grep -ve "^\.\/debian" 
} 

############# Find all python src files in dir 
# usage: py-src [dir] 
function py-src() { 
    local USAGE="usage: py-src [dir]" 
    [ "$1" == "-h" ] && (>&2 echo $USAGE) && return 
    local SRC=. 
    [ -n "$1" ] && local SRC="$1" 
    find ${SRC} -name "*.py" 
} 

############# # Find all R src files in dir 
# usage: r-src [dir] 
function r-src() { 
    local USAGE="usage: r-src [dir]" 
    [ "$1" == "-h" ] && (>&2 echo $USAGE) && return 
    local SRC=. 
    [ -n "$1" ] && local SRC="$1" 
    find ${SRC} -regex ".*\.[rR]" 
} 

# Find all JSON files in dir 
# usage: json-src [dir] 
function json-src() { 
    local USAGE="usage: json-src [dir]" 
    [ "$1" == "-h" ] && (>&2 echo $USAGE) && return 
    local SRC=. 
    [ -n "$1" ] && local SRC="$1" 
    find ${SRC} -iname "*.json" 
} 

############# Function  extract
extract() { 
   if [ -f "$1" ]; then 
     case "$1" in 
       *.tar.bz2)   tar xjf "$1"   ;; 
       *.tar.gz)    tar xzf "$1"   ;; 
       *.bz2)       bunzip2 "$1"   ;; 
       *.rar)       unrar x "$1"     ;; 
       *.gz)        gunzip "$1"    ;; 
       *.tar)       tar xf "$1"    ;; 
       *.tbz2)      tar xjf "$1"   ;; 
       *.tgz)       tar xzf "$1"   ;; 
       *.zip)       unzip "$1"     ;; 
       *.Z)         uncompress "$1" ;; 
       *.7z)        7z x "$1"      ;; 
       *)           echo "'$1' cannot be extracted using the 'extract' function" ;; 
     esac 
   else 
     echo "'$1' is not a valid file" 
   fi 
} 

############# function clone
function clone() { 
     if [ $# -lt 1 ]; then 
         echo "Usage: clone <repository_url>" 
         return 1 
     fi 

     default_destination="$HOME/clones" 
     counter=1 

     # Find the next available number for the directory 
     while [ -d "$default_destination/clone-$counter" ]; do 
         counter=$((counter + 1)) 
     done 

     destination="$default_destination/clone-$counter" 

     git clone -q "$1" "$destination" 
     if [ $? -ne 0 ]; then 
         echo "Error: Cloning failed." 
         return 1 
     fi 

     echo "Cloning successful. Repository cloned to '$destination'" 
}


###########command not found handle########
command_not_found_handle() {
   local blue='\033[0;34m'  # Define a cor azul
   local red='\033[0;31m'   # Define a cor vermelha
   local reset='\033[0m'    # Reseta as cores

   printf "${blue}Comando não encontrado:${red} $1${reset}\n"  # Exibe a mensagem formatada
   return 127; }

######### função que usa o builtin pra personalizar a execução do cd ou cs ..
cd() {
    if [ "$1" == ".." ]; then
        builtin cd .. && ls
    elif [ -n "$1" ]; then
        builtin cd "$1" && ls
    else
        builtin cd && ls
    fi
}
