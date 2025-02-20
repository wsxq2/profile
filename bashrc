## color prompt
##############################################################################
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi


if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# alternative
#PROMPT_COMMAND='printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
##############################################################################


## for history
##############################################################################
shopt -s histappend                      # append to history, don't overwrite it
export PROMPT_COMMAND="history -a; history -c; history -r;" # auto refresh history

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
##############################################################################


## language and encoding
##############################################################################
export LANG='en_US.UTF-8'
##############################################################################


## ulimit
##############################################################################
# 设置 core 大小为无限
#ulimit -c unlimited
# 设置 stack 大小为无限
#ulimit -s unlimited
# 设置文件大小为无限
#ulimit unlimited
##############################################################################


# ls ./**/*.c
shopt -s globstar
# ls !(.git)
shopt -s extglob
# $HOME<Tab>--> /home/wsxq2
shopt -s direxpand


pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}


## local
##############################################################################
LOCAL_PATH="$HOME/.local"
pathmunge $LOCAL_PATH/sh
pathmunge $LOCAL_PATH/expect

source "$LOCAL_PATH/sh/library.sh"

LOCAL_BIN="$LOCAL_PATH/bin"
pathmunge $LOCAL_BIN
##############################################################################


## vim
##############################################################################
declare MACHINE=""
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    CYGWIN*)    MACHINE=Cygwin;;
    MINGW*)     MACHINE=MinGw;;
    MSYS_NT*)   MACHINE=Git;;
    *)          MACHINE=Linux;;
esac

declare -x USED_VIM=""
if [[ $MACHINE == Linux ]]; then
    if [[ -x `which nvim` ]] &> /dev/null; then
        USED_VIM=`which nvim`
    elif [[ -x $LOCAL_BIN/vim ]]; then
        USED_VIM=$LOCAL_BIN/vim
    elif [[ -x /usr/local/bin/vim  ]]; then
        USED_VIM=/usr/local/bin/vim
    elif [[ -x /usr/bin/vim ]]; then
        USED_VIM=/usr/bin/vim
    elif [[ -x `which vim` ]]; then
        USED_VIM=`which vim`
    else
        echo 'no vim found'
    fi
else
    USED_VIM=vim
fi

[[ -n $USED_VIM ]] &&  export EDITOR=$USED_VIM || export EDITOR=/usr/bin/vi

alias vim="$USED_VIM"
alias v=vim
alias vimdiff="vim -d"
alias vd=vimdiff
alias view="vim -R"
##############################################################################


## python
##############################################################################
[[ -f $HOME/.config/python/startup.py ]] && export PYTHONSTARTUP=$HOME/.config/python/startup.py
##############################################################################


## java
##############################################################################
# for mac: `java_home`; for recent java version: `java -version`; for java version >= 1.7: `java -XshowSettings:properties -version`
export JAVA_HOME=`java -XshowSettings:properties -version |& grep java\.home | awk -F' ' '{print $3}'`
##############################################################################


## ofen used directory
##############################################################################
export mp="$HOME/.MyProfile"
[[ -d /mnt/c/Users/wsxq2 ]] && winhome_prefix=/mnt || winhome_prefix=
winhome=$winhome_prefix/c/Users/wsxq2
if [[ -d $winhome ]]; then
    export dow="$winhome/Downloads"
    export des="$winhome/Desktop"
    export bl="$winhome/Documents/MY/workspace/wsxq2.github.io/_posts"
else
    export bl="$HOME/.wsxq2.github.io/_posts"
fi
##############################################################################


## ofen used alias and func
##############################################################################
alias ls="ls --color=auto"
alias l=ls
alias ll="ls -lh"
#alias la='ls -a'
alias md=mkdir
alias sdn="sudo shutdown now"
alias tree='tree --dirsfirst -aF -I .git'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vb='vim ~/.bashrc'
alias sb='source ~/.bashrc'
alias vv='vim ~/.vimrc'
alias vlr="vim $bl/2019-11-13-学习记录.md"
alias lb='lsblk -ao +FSTYPE,LABEL,PARTUUID,MODEL'
alias grep="grep --color=auto"
alias g='grep -I --exclude-dir=.git'
alias gr='g -r -n'
alias du.='for f in * ; do du -sh $f; done | sort -h'
alias rp='realpath'
alias le='less'
alias wh='which'
alias me="env | grep '^[a-z_]\+='" # my env
alias gdb='HISTSIZE=70000000 gdb -q'

f(){
    name="${1}"
    path="${2:-.}"
    find "$path" -name "$name"
}

function leh() {
    "$1" --help | less
}

function pdb(){
    python -m pdb $1
}

function pg(){
    ps aux | grep -v "grep" |grep $1
}

deploy_local_github_pages_environment(){
    rvm install 2.7.2
    rvm use 2.7.2
    gem install bundler:2.2.1
    pushd $bl/..
    bundle install
    popd
}

function jes(){
    pg jekyll > /dev/null && ret=0 || ret=$?

    if [ $ret -eq 0 ]; then
        kill `pg jekyll | awk '{print $2}'`
    else
        if [ -d "$bl" ]; then
            {
                pushd $bl/..
                nohup jekyll serve -H 0.0.0.0 -P 8888 -q --watch &
                popd
            } &> /dev/null
        fi
    fi
}

function runc(){
    gcc -g -std=c99 $1 && ./a.out $2 $3 $4 $5 $6
}

function runcpp(){
    g++  $1 && ./a.out $2 $3 $4 $5 $6
}

function dbgc(){
    gcc -g -std=c99 $1 && gdb ./a.out
}

function md2html(){
    rm -rf html
    java -jar /usr/bin/md2html.jar -i . -o html
    rm -rf html/*.md
}

# vimdiff dir
function vdd()
{
    # Shell-escape each path:
    DIR1=$(printf '%q' "$1"); shift
    DIR2=$(printf '%q' "$1"); shift
    vim $@ -c "DirDiff $DIR1 $DIR2"
}

function urldecode(){
    echo -e "$(echo $1|sed 'y/+/ /; s/%/\\x/g')"
}

function urlencode(){
    python -c "import urllib.parse; print(urllib.parse.quote('''$1''', safe=''))"
}

function t() {
    tmux ls | grep $USER &>/dev/null && tmux a -t $USER || tmux new -s $USER
}

grrules(){
    local str
    str="$1"
    [[ x$str != x ]] || return 1
    find -name '*.rules' |xargs -I@ grep -Hn --color=auto "$str" @
} 

grsid(){
    local sid
    sid="$1"
    [[ x$sid != x ]] || return 1
    find -name '*.rules' |xargs -I@ grep -Hn --color=auto "sid:[ ]*$sid[ ]*;" @
} 

grallsid(){
    find -name '*.rules' |xargs -I@ grep -o 'sid:[ ]*[0-9]\+[ ]*;' @ |cut -d':' -f2|sort -n|uniq > allsid.txt
}

function ba() {
    echo -n "$1" | base64 -w0
}


function bd() {
    echo -n "$1" | base64 -d -w0
}

function hg() {
    local command="$1"
    shift
    "$command" --help |& grep -- "$@"
}
alias ht='history | tail'
function hig() {
    history | grep "$@" |grep -v 'hig'
}

vg(){
    local file="$(cut -d: -f1 <<<"$1")"
    local ln="$(cut -d: -f2 <<<"$1")"
    v +$ln $file
}

decode_gdb_str(){
    local str="$1"
    local code="${2:-gbk}"
    python3 <<<"print(b'$str'.decode('$code'));"
}

# 转换为 10 进制数
todec ()
{
    python -c "print int($1)"
}

# 转换为 2 进制数
tobin () 
{ 
    python -c "print bin($1)"
}

# 转换为 16 进制数
tohex () 
{ 
    python -c "print hex($1)"
}

# Reduce ~/.Bash_History
function rbh(){
    sed -r '/^ *[0-9]* *\b(ls|tree|history|ping|ip|netstat|ss|man|apropos|jobs|cat|nc|sp|type|whatis|sha256sum|ll|lls|df|diff|echo|tail|head|help|view|w|top|complete|date|gca|vb|vv|wcd|grep|egrep|cd)\b/d;
    /(vim (a|b|c|d|e|x|y|z)|\b\w+\b (a|b|c|d|e|x|y|z|-h|--help|help|version)|rpm (-qf|-ql)|yum (info|search|history|repolist|clean|deplist|help)|(systemctl|git) status|%)/d' ~/.bash_history | uniq
}

# windows path
wp(){
    local array1 array2 disk path IFS
    path="$1"

    IFS='\'; read -r -a array1 <<< "$path"
    array2=("${array1[@]:1}")
    disk=$(echo -n "${array1[0]:0:1}" | awk '{print tolower($0)}')
    IFS='/'; echo -n "$winhome_prefix/$disk/${array2[*]}"
}
wcd(){
    cd $(wp "$1")
}
pw(){
    pushd $(wp "$1")
}

# for dirs
alias p=pushd
alias po=popd
alias d='dirs -l -v'

# for jobs
alias j=jobs

# for git
alias gc='git checkout'
alias gb='git branch'
function gs() {
    git status "$@"
}
alias gss='git status --short'
function gsm() {
    gss "$@" | grep -v "??" | awk '{print $NF}'
}
function gsu() {
    gss "$@" | grep "??" | awk '{print $NF}'
}
alias gl='git log'
alias ga='git add'
alias gm='git commit'
alias gma='git commit --amend'
alias gmm='git commit -m'
alias gdd='git diff'
alias gd='git d'
alias gp='git pull'
alias ga.='gss | xargs git add'
alias gph='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gv='git rev-parse --short HEAD'
alias gpu='git push'
alias gbh='git rev-parse --abbrev-ref HEAD'
alias gt='git tag'

git_stat_lines()
{
    between="${1:-}"
    author="${2:-NULL}"
    excludefile_filelist="${3:-NULL}"

    [[ $author == NULL ]]  && author_str="" || author_str="--author=$author"
    [[ $excludefile_filelist == NULL ]] && ef_str="/dev/null" || ef_str="$excludefile_filelist"
git log $between $author_str --pretty=tformat: --numstat | grep -Fvf $ef_str |gawk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s removed lines: %s total lines: %s\n", add, subs, loc }' -
}

# for svn
alias ss_='svn status'
alias sa='svn add'
alias sr='svn rm'
alias sd='svn diff'
alias sm='svn commit'
alias su_='svn update'
alias sll='svn log -v | less'
alias ss?='svn status | grep "^\?" | tr "^\?" " " | sed "s/[ ]*//" | sed "s/[ ]/\\\ /g"'
alias ssa='ss? | xargs svn add'
alias ss!='svn status | grep "^\!" | tr "^\!" " " | sed "s/[ ]*//" | sed "s/[ ]/\\\ /g"'
alias ssr='ss! | xargs svn rm'
alias si='svn propedit svn:ignore'

# for script
alias script_log='[[ -d $HOME/shell-log ]] || mkdir $HOME/shell-log && script $HOME/shell-log/`date +%F_%T`.log'

# for vim file
alias vr='v README.md'
alias vig='v .gitignore'
alias vm='v Makefile'

# for sqlite3
alias sqlite3="rlwrap -a -N -c -i -f ~/.config/rlwrap/sqlite3_completions sqlite3"

# for cscope, ctags
cct(){
    #rm -rf cscope.*
    cscope -Rbkq
    #rm -rf ctags
    ctags -R --languages=C,C++
}

# last result (return code)
alias lr='[[ $? -eq 0 ]] && green Success || yellow Failed'

# timer
tm(){
    for (( i="${1:-30}"; i>0; i--)); do
        sleep 60;    
    done

    while true; do
        echo -e '\a'
        sleep 1
    done
}

tmb(){
    ( tm "$@") &
    TM_PID=$!
}

tme(){
    kill $TM_PID
    unset TM_PID
}

m(){
    if [[ -z $TM_PID ]]; then
        tmb "$@"
    else
        tme
    fi 
}
##############################################################################


## qshell
##############################################################################
# Get bucket Wsxq2 all links
function gw(){
    qshell listbucket wsxq2 fileList.txt
    cat fileList.txt | awk -F '\t' ' {print "http://wsxq12.55555.io/"$1}'
    rm fileList.txt
}

# qshell upload
function qu(){
    qshell qupload2 -src-dir="$bl/images" -bucket=wsxq2 -overwrite=true -skip-file-prefixes="" -skip-path-prefixes="" -skip-fixed-strings=".svn,.git,.log" -skip-suffixes="" -log-file="$bl/images/upload.log" -log-level=debug -rescan-local=true -ignore-dir=false -check-exists=true -check-hash=true
}
##############################################################################


## proxy
##############################################################################
# View Proxy
vp(){
    local message=$http_proxy
    [[ -z $message ]] && message='proxy not set'
    echo $message
}

# Set Proxy
function sp(){
    local host port
    host=$1
    port=$2
    export http_proxy=http://$host:$port/
    export https_proxy=http://$host:$port/
    export HTTPS_PROXY=http://$host:$port/
    export no_proxy=localhost,127.0.0.1,192.168.0.0/24,172.0.0.0/8
    export NO_PROXY=localhost,127.0.0.1,192.168.0.0/24,172.0.0.0/8
    # export ftp_proxy=http://127.0.0.1:1080/
    # export all_proxy=socks://127.0.0.1:1080/
}

# set proxy lo
function splo(){
    sp 127.0.0.1 7890
}

# set proxy hostonly
function spho(){
    sp 192.168.56.200 7890
}
spho

# Unset Proxy
function up() {
    unset http_proxy https_proxy HTTPS_PROXY no_proxy NO_PROXY # ftp_proxy all_proxy
}

# Test Proxy
function tp() {
    local proxy="${1:-$http_proxy}"
    [[ $proxy == NULL ]] && proxy_str='' || proxy_str="--proxy $proxy"
    curl -4 --max-time 3 --write-out %{http_code} --silent --head $proxy_str --output /dev/null https://www.google.com &> /dev/null && green Success || yellow Failed
}
##############################################################################


## for mvn
##############################################################################
function get_mvn_completion() {
    wget https://raw.github.com/dimaj/maven-bash-completion/master/bash_completion.bash --output-document /etc/bash_completion.d/mvn
}

# mvn generate
function mg() {
    mvn -e archetype:generate -DgroupId=io.x55555.wsxq2 -DartifactId=$1 -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
    rm -rf $1/src/main/java/io/x55555/wsxq2/App.java
}
# maven
export M2_HOME=/usr/local/maven
export MAVEN_HOME=$M2_HOME
pathmunge ${M2_HOME}/bin
#export MAVEN_OPTS='-Xms256m -Xmx512m -Dmaven.artifact.threads=5'
##############################################################################


## for nvm(node version manager)
##############################################################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
##############################################################################


## for pyenv
##############################################################################
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#if command -v pyenv 1>/dev/null 2>&1; then
#  eval "$(pyenv init -)"
#fi
##############################################################################


## completion
##############################################################################
# for pip
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
        COMP_CWORD=$COMP_CWORD \
        PIP_AUTO_COMPLETE=1 $1 ) )

}
complete -o default -F _pip_completion pip

# bash_completion
function bash_completion()
{
    # Check for interactive bash and that we haven't already been sourced.
    [ -z "$BASH_VERSION" -o -z "$PS1" -o -n "$BASH_COMPLETION_COMPAT_DIR" ] && return

    # Check for recent enough version of bash.
    bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}

    declare -i bash_completion_installed=0
    [ -d /etc/profile.d/bash_completion.sh ] && bash_completion_installed=1

    if [ $bmajor -gt 4 ] || [ $bmajor -eq 4 -a $bminor -ge 1 ]; then
        [ -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion" ] && \
            . "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion"

        bash_completion_script=$([[ -r /usr/share/bash-completion/bash_completion ]] && \
            echo /usr/share/bash-completion/bash_completion || \
            echo /usr/local/share/bash-completion/bash_completion)

        if shopt -q progcomp && [ -r $bash_completion_script ]; then
            # Source completion code.
            . $bash_completion_script
        fi

        if [[ -x /etc/bash_completion.d ]];then
            for x in /etc/bash_completion.d/*;do
                if [[ $x = *yum* ]]; then #如果没有安装 bash_completion，就跳过包含yum的补全脚本
                    if [[ $bash_completion_installed -eq 0 ]]; then
                        continue
                    fi
                fi
                . $x
            done
        fi
    fi
    unset bash bmajor bminor
}
bash_completion
##############################################################################


## for server maintain, view access ip info
##############################################################################
function ipinfo() {
    local ip count region city org
    while read line
    do
        ip=`awk -F'\t' '{print $1}' <<<"$line"`
        count=`awk -F'\t' '{print $2}' <<<"$line"`
        region=`curl -s https://ipapi.co/$ip/region/`
        city=`curl -s https://ipapi.co/$ip/city/`
        org=`curl -s https://ipapi.co/$ip/org/`
        printf "%-15s  %-8s  %-40s  %-20s  %-s\n" "$ip" "$count" "${region:-NULL}" "${city:-NULL}" "${org:-NULL}"
    done < "${1:-}"
}

# httpd access log host statistic
function ipcount(){
    local TMPFILE
    case "$1" in
        net )
            sed -r -e '/awesomepath/!d' -e '/awesomepath/s/^([0-9]+\.[0-9]+\.[0-9]+).*$/\1/' "$2" |sort |uniq -c |sed -r 's/^ *([0-9]+) ([0-9.]+)$/\2\t\1/' |sort
            ;;
        ip )
            TMPFILE="$(mktemp -t --suffix=.txt _ipcount.XXXXXX)"
            sed -r -e '/awesomepath/!d' -e '/awesomepath/s/^([0-9.]+) .*$/\1/' "$2" |sort |uniq -c |sed -r 's/^ *([0-9]+) ([0-9.]+)$/\2\t\1/' |sort > $TMPFILE
            ipinfo $TMPFILE
            ;;
    esac
}

# v2ray access log website statistic
function docount() {
    sed -r -e '/tcp:/!d' -e  's/.*tcp:([^:]+):.*/\1/' "$1" |sort |uniq -c|sort -n |tail -n 100
}
##############################################################################


## install_xxx and deploy_xxx
##############################################################################
# for tmux
# change from https://gist.github.com/pokev25/4b9516d32f4021d945a140df09bf1fde
install_tmux(){
    # Install tmux 2.8 on Centos
    pushd $HOME

    # install deps
    yum install gcc kernel-devel make ncurses-devel -y

    # DOWNLOAD SOURCES FOR LIBEVENT AND MAKE AND INSTALL
    curl -LOk https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
    tar -xf libevent-2.1.8-stable.tar.gz
    cd libevent-2.1.8-stable
    ./configure --prefix=/usr/local
    make
    sudo make install

    # DOWNLOAD SOURCES FOR TMUX AND MAKE AND INSTALL

    curl -LOk https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz
    tar -xf tmux-2.8.tar.gz
    cd tmux-2.8
    LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
    make
    sudo make install

    # pkill tmux
    # close your terminal window (flushes cached tmux executable)
    # open new shell and check tmux version
    tmux -V

    popd
}
# for tpm
# in tmux: <c-b>,I and <c-b>,U
install_tpm(){
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function deploy_clash(){
    local version prefix
    version="${1:-v1.3.0}"
    prefix=/usr/local/share/clash

    wget -O clash-linux-amd64.gz https://github.com/Dreamacro/clash/releases/download/$version/clash-linux-amd64-$version.gz
    gzip -d clash-linux-amd64.gz
    [[ -d $prefix ]] || mkdir -p $prefix

    mv -f clash-linux-amd64 $prefix/clash
    chmod +x $prefix/clash

    wget -O $prefix/config.yaml https://sub.wsxq2.xyz/clash.yml

    wget -O $prefix/Country.mmdb https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb

    cat <<EOF >/etc/systemd/system/clash.service
[Unit]
Description=clash
After=network.target

[Service]
ExecStart=$prefix/clash -d $prefix
ExecReload=$prefix/clash -d $prefix
ExecReload=/bin/kill -HUP \$MAINPID
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
Alias=clash.service
EOF

systemctl daemon-reload
systemctl start clash
systemctl enable clash
}

function install_vim8(){
    sudo yum install python-devel ncurses-devel ncurses -y
    cd ~ && \
        wget https://github.com/vim/vim/archive/v8.2.1738.tar.gz -O vim-8.2.1738.tar.gz && \
        tar xf vim-8.2.1738.tar.gz && \
        cd vim-8.2.1738 && \
        ./configure --enable-fail-if-missing --disable-perlinterp --enable-pythoninterp --disable-rubyinterp \
        --enable-cscope --with-features=huge --enable-multibyte --with-compiledby=$USER --prefix=$HOME/.local && \
        make && \
        make install && \
        cd -

    }

# need sudo: sudo bash -c "$(declare -f config_pptp_client); config_pptp_client"
# 未测试，不可反复执行（重复执行不安全）
deploy_pptp_client(){
    local server="${1-:47.97.121.219}"
    local user="${2:-wsxq2-master}"
    local pass="${3:-36798147}"

    yum install ppp pptp pptp-setup -y
    echo nf_conntrack_pptp >> /etc/modules-load.d/vpn.conf
    pptpsetup --create ali --server $server --username $user --password $pass  --start --encrypt
    cat <<EOF > /root/auto-reconnect-pptp.sh
#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ip a | grep 'ppp[0-9]:' || pppd call ali
EOF
    chmod +x /root/auto-reconnect-pptp.sh
    echo '*/1 * * * * root /root/auto-reconnect-pptp.sh > /root/auto-reconnect-pptp.log 2>&1' >> /etc/crontab
}

# 前提：GCC 版本较高。推荐使用 devtoolset-8 环境，详见 <https://www.softwarecollections.org/en/scls/rhscl/devtoolset-8/>
install_llvm(){
    pushd $HOME

    set -exu

    git clone --depth=1 https://github.com/llvm/llvm-project.git
    cd llvm-project
    mkdir build && cd build
    #cmake -G "Unix Makefiles" -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DCMAKE_INSTALL_PREFIX=~/.local/share/llvm -DCMAKE_BUILD_TYPE=Release ../llvm
    cmake -G "Unix Makefiles" -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DCMAKE_BUILD_TYPE=Release ../llvm
    make -j 8
    sudo make install

    set +exu

    popd
}

install_gcc8(){
    sudo yum install centos-release-scl -y
    sudo yum install devtoolset-8 -y
}

use_gcc8(){
    scl enable devtoolset-8 bash
}

install_cmake(){
    local version="${1:-3.21.2}"
    wget https://github.com/Kitware/CMake/releases/download/v${version}/cmake-${version}-linux-x86_64.sh
    sh cmake-${version}-linux-x86_64.sh
}

install_retdec(){
    curl https://raw.githubusercontent.com/avast/retdec/master/Dockerfile | docker build -t retdec -
}

install_suricata(){
    git clone http://github.com/OISF/suricata.git
    cd suricata
    git checkout 6.0.2
    #use_gcc8
    ./autogen.sh
    ./configure --enable-unittests --prefix=`pwd`/__install CFLAGS=-D_GNU_SOURCE
    make
    make install
}

install_nvim(){
    pushd $HOME
    set -x
    curl -LOk https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    sudo mv squashfs-root / && sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
    set +x
    popd
}

install_bear(){
    pushd $HOME
    wget https://github.com/rizsotto/Bear/archive/refs/tags/2.1.5.tar.gz
    tar xf 2.1.5.tar.gz
    cd Bear-2.1.5/
    mkdir build
    cd build
    cmake ..
    make
    sudo make install
    popd
}

install_pandoc(){
    local TGZ DEST

    [[ -d $HOME/install ]] || mkdir $HOME/install
    pushd $HOME/install
    wget -O pandoc.tar.gz https://github.com/jgm/pandoc/releases/download/2.17.1.1/pandoc-2.17.1.1-linux-amd64.tar.gz
    TGZ=pandoc.tar.gz
    DEST=/usr/local/
    sudo tar xvzf $TGZ --strip-components 1 -C $DEST
    popd
}
##############################################################################


## for rvm
##############################################################################
install_rvm(){
    command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
    command curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
    # or
    #gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

    \curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles stable
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
pathmunge $HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
##############################################################################


## for serial
##############################################################################
srt ()
{
    local ip com
    ip="$1"
    com="$2"

    ttydir=$HOME/.dev/${ip}
    [[ -d $ttydir ]] || mkdir -p $ttydir
    nohup socat pty,link=$ttydir/tty${com},raw tcp:${ip}:100${com} &> /dev/null &
}
mc(){
    local re com ip
    com="${1:-05}"
    ip="${2:-${device_ip_prefix}.10}"

    minicom -c on -D $(realpath $HOME/.dev/${ip}/tty${com})
}

mi(){
    local ip com
    com="${1:-05}"
    ip="${2:-${device_ip_prefix}.10}"
    pg "${ip}:100${com}" > /dev/null || srt $ip $com
    sleep 0.1
    mc $com $ip
}
##############################################################################


## for pandoc
##############################################################################
type pandoc &> /dev/null && eval "$(pandoc --bash-completion)"
##############################################################################


# fix termial problem
alias sts='stty sane'

# for clangd
pathmunge $HOME/.local/share/llvm/bin

# compile one file with compile_commands.json
compile_one(){
    local file="${1}"
    python3 - <<EOF
import json
import os

with open('compile_commands.json') as f:
    ccs=json.load(f)
for cc in ccs:
    if cc['file'].endswith('$file'):
        print(cc['command'])
        os.system(cc['command'])
        break
EOF
}


# Windows text file format to Unix text file format
function w2u(){
    readarray -t all_source_file< <(find . -path ./after_iconv -prune -o \( -name '*.cpp' -o -name '*.c' -o -name '*.h' -o -name '*.txt' -o -name '*.java' \) -type f -print)

    TMPFILE1="$(mktemp -t --suffix=.txt a_sh.XXXXXX)"
    TMPFILE2="$(mktemp -t --suffix=.txt a_sh.XXXXXX)"
    trap "rm -f '$TMPFILE1 $TMPFILE2'" 0               # EXIT
    trap "rm -f '$TMPFILE1 $TMPFILE2'; exit 1" 2       # INT
    trap "rm -f '$TMPFILE1 $TMPFILE2'; exit 1" 1 15    # HUP TERM

    for f in "${all_source_file[@]}"; do
        #echo $f
        dir_of_f="after_iconv/$(dirname $f)"
        #echo $dir_of_f
        if [[ ! -d "$dir_of_f" ]]; then
            echo mkdiring $dir_of_f
            mkdir -p $dir_of_f
        fi

        if [[ ! "$(file -b --mime-type $f)" = text/* ]]; then
            continue
        fi

        echo iconving $f to after_iconv/$f

        \cp -af $f $TMPFILE1

        encoding="$(file -b --mime-encoding $TMPFILE1)"
        if [[ ! "$encoding" = utf\-8 ]]; then
            iconv -f "$encoding" -t UTF-8 -o $TMPFILE2 $TMPFILE1
            \cp -af $TMPFILE2 $TMPFILE1
        fi

    #sed -e '$s/.*/&\n/' <temp1 > temp2

    if [[ "$(file $TMPFILE1)" = *CRLF* ]]; then
        tr -d '\r' < $TMPFILE1 > $TMPFILE2
        \cp -af $TMPFILE2 $TMPFILE1
    fi

    if [[ "$(file $TMPFILE1)" = *BOM* ]]; then
        sed '1s/^.//' $TMPFILE1 > $TMPFILE2
        \cp -af $TMPFILE2 $TMPFILE1
    fi
    \cp -af $TMPFILE1 after_iconv/$f
done
}


unset -f pathmunge

# for X service
export DISPLAY=192.168.56.200:0.0

# for ROS
[[ -f /opt/ros/humble/setup.bash ]] && source /opt/ros/humble/setup.bash
[[ -f /opt/ros/noetic/setup.bash ]] && source /opt/ros/noetic/setup.bash
export ROS_DOMAIN_ID=1
export ROS_LOCALHOST_ONLY=1
[[ -f /usr/share/colcon_cd/function/colcon_cd.sh ]] && source /usr/share/colcon_cd/function/colcon_cd.sh
export _colcon_cd_root=/opt/ros/noetic/
[[ -f /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash ]] && source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
export GAZEBO_MODEL_PATH=/home/ubuntu/auto_forklift_pallet_detection/src/forklift_simulator/models:$GAZEBO_MODEL_PATH
