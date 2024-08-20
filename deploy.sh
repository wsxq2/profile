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
    sp $PROXY_HOST 7890
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
    [[ -x /usr/local/bin/ccls ]] || install_ccls
    #sudo snap install prettier --beta # code formatter for json markdown and so on
    #sudo snap install black # python code formatter
    #sudo snap install ccls --classic
    #sudo snap install bash-language-server --classic
    #sudo snap install pyright --classic
    #sudo apt install -y cargo npm

    # nvim plugin manually build
    # rsync.nvim
    #cd ~/.local/share/nvim/lazy/rsync.nvim && make -j8
    # markdown-preview.nvim
    #cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app && npm install
}

PROXY_HOST="${1:-192.168.16.1}"

FILES=( $(find . ! -path '*/.git/*' ! -name README.md ! -name deploy.sh ! -name '*.swp' ! -name .gitignore -type f) )

for f in ${FILES[@]}; do
    [[ ${f:0:2} == ./ ]] && f="${f:2}"
    handle_one_file "$f"
done

sed -i "s/192.168.56.200/$PROXY_HOST/g" ~/.bashrc

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

if [[ $MACHINE == Linux ]]; then
    rm -rf ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    install_nvim_ide
fi


