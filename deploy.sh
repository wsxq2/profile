#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#set -x

#PWD=$(pwd)


# 方案一
create_dir_if_not_exists(){
    [  -d "$1" ] || mkdir -p "$1"
}

sp ()
{
    local host port;
    host=$1;
    port=$2;
    export http_proxy=http://$host:$port/;
    export https_proxy=http://$host:$port/;
    export HTTPS_PROXY=http://$host:$port/;
    export no_proxy=localhost,127.0.0.1,192.168.0.0/24,172.0.0.0/8;
    export NO_PROXY=localhost,127.0.0.1,192.168.0.0/24,172.0.0.0/8
}

spho ()
{
    sp 192.168.56.200 7890
}

handle_one_file(){
    f="$1"
    echo handling $f
    create_dir_if_not_exists $(dirname "$HOME/.$f")
    #[[ -f "$HOME/.$f" ]] && cp -L "$HOME/.$f" "$HOME/.$f.bak"
    ln -sf "$PWD/$f" "$HOME/.$f"
}

install_nvim ()
{
    pushd $HOME;
    set -x;
    sudo apt install curl -y;
    curl -LOk https://github.com/neovim/neovim/releases/latest/download/nvim.appimage;
    chmod u+x nvim.appimage;
    ./nvim.appimage --appimage-extract;
    sudo mv squashfs-root / && sudo ln -s /squashfs-root/AppRun /usr/bin/nvim;
    set +x;
    popd
}

install_ccls ()
{
    pushd $HOME;
    set -x
    # install dependices
    sudo apt install -y zlib1g-dev libncurses-dev
    sudo apt install -y clang libclang-dev

    # download code
    git clone --depth=1 --recursive https://github.com/MaskRay/ccls
    cd ccls

    # build
    cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_PREFIX_PATH=/usr/lib/llvm-7 \
        -DLLVM_INCLUDE_DIR=/usr/lib/llvm-7/include \
        -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-7/
    cmake --build Release

    # install
    cd Release && sudo make install

    set +x;
    popd
}

install_nvim_ide()
{
    spho
    [[ -x /usr/bin/nvim ]] || install_nvim
    sudo apt install -y gcc wget iputils-ping python3-pip git bear tig shellcheck ripgrep 
    sudo apt install -y fd-find unzip cmake
    pip3 install pynvim
    [[ -x /usr/local/ccls ]] || install_ccls
    #sudo snap install prettier --beta # code formatter for json markdown and so on
    #sudo snap install black # python code formatter
    #sudo snap install ccls --classic
    #sudo snap install bash-language-server --classic
    #sudo snap install pyright --classic
    #sudo apt install -y cargo npm

    # 安装编译 neovim 的各种依赖 https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites
    #sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

    # nvim plugin manually build
    # rsync.nvim
    #cd ~/.local/share/nvim/lazy/rsync.nvim && make -j8
    # markdown-preview.nvim
    #cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app && npm install
}

if [[ $# = 0 ]]; then 
    FILES=( $(find . ! -path '*/.git/*' ! -name README.md ! -name deploy.sh ! -name '*.swp' ! -name .gitignore -type f) )
else
    FILES=( "$@" )
fi
for f in ${FILES[@]}; do
    [[ ${f:0:2} == ./ ]] && f="${f:2}"
    handle_one_file "$f"
done

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install_nvim_ide

# 方案二
#function handle_dir() {
#    find 
#    for f in $@  ; do
#        ln -sf $PWD/$f $HOME/.$f
#    done
#}
#
#main(){
#    ln -sf $PWD/bashrc $HOME/.bashrc
#    ln -sf $PWD/vimrc $HOME/.vimrc
#    ln -sf $PWD/inputrc $HOME/.inputrc
#    ln -sf $PWD/my.cnf $HOME/.my.cnf
#    create_dir_if_not_exists $HOME/.config/git
#    handle_dir config/git/*
#    create_dir_if_not_exists $HOME/.config/python
#    handle_dir config/python/*
#    create_dir_if_not_exists $HOME/.config/pip
#    handle_dir config/pip/*
#}

