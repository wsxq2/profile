# MyProfile

这是我在 Linux 中使用的各种配置文件，例如`~/.bashrc`, `~/.vimrc`等等

建议 fork 到自己的仓库，再按需修改，并自行维护（毕竟每个人的需求是不一样的）

## 快速使用

```bash
git clone https://github.com/wsxq2/profile.git ~/.MyProfile
cd ~/.MyProfile
./deploy.sh 127.0.0.1 # 注意替换为你的代理主机，默认代理端口是 7890
```

**请务必修改 git 的用户名和邮箱设置**, 有两个方法，任选其一即可：

1. 通过 git 命令设置：

   ```bash
   git config --global user.name your_name
   git config --global user.email your_email
   ```

1. 修改 git 配置文件。找到 `~/.config/git/config` 文件并打开，将 `name` 和 `email` 修改为对应的值。

如果你还想使用我的 nvim 配置和输入法配置（通常不需要，我的输入法配置是五笔）：

```bash
git submodule update --init
```

`bashrc` 中会将 `mp` 变量设置为 `~/.MyProfile`，后续可以直接使用 `cd $mp` 到此目录，此目录中有一个默认的 `.env` 文件，用于添加自定义的、非版本跟踪的变量设置和命令：

```
V_PROXY_HOST=127.0.0.1
V_PROXY_PORT=7890
#V_DP=127.0.0.1:0.0 # DISPALY 变量
V_ROS_DOMAIN_ID=3
V_ROS_CUSTOM_SETUP=$HOME/liftbot/install/setup.bash
V_CYCLONEDDS_URI=$HOME/liftbot/dds/cyclonedds_lo.xml
```

## 目录结构
本目录结构和用户家目录的结构完全相同，但文件名少了个`.`（英文句号），如`bashrc`，这是为了 ls 时能直接看到。而其中一键部署脚本`deploy.sh`的作用是将这些文件创建软链接到家目录中的正确位置（会在前面加`.`）。这样的好处是你对这些配置文件的修改都处于版本跟踪下。详情查看`deploy.sh`脚本内容


```
.
├── bashrc # bash 配置文件
├── clang-format # 代码格式规范
├── config # 部分程序配置
│   ├── git
│   │   ├── config # git 配置文件
│   │   └── gitignore # git 默认忽略文件
│   ├── nvim
│   │   └── init.vim # nvim 配置文件
│   ├── pip
│   │   └── pip.conf # pip 配置文件
│   ├── python
│   │   └── startup.py # python 命令行程序配置文件
│   └── rlwrap
│       └── sqlite3_completions # sqlite 命令行程序自动补全
├── deploy.sh # 部署脚本
├── gdbinit # gdb 配置文件
├── inputrc # 终端配置文件（影响方向键中上下键的行为）
├── local # 用户子环境
│   ├── expect # expect 脚本
│   │   └── library.expect
│   └── sh # sh 脚本
│       ├── library.sh # bash 函数库
│       └── svndiffwrap.sh # 让 svn diff 时使用 vimdiff 工具
├── minirc.dfl # minicom 配置文件
├── my.cnf # mysql 配置文件
├── README.md # 本文档
├── ssh # ssh 相关文件
├── subversion # svn 相关文件
│   └── config # svn 配置文件
├── tmux.conf # tmux 配置文件
├── vim # vim 相关文件
│   ├── autoload
│       └── plug.vim # vim-plug：管理插件的插件
│
└── vimrc # vim 配置文件

14 directories, 56 files
```

## 使用方法

### 别名或函数

可使用 `type` 命令查看其定义，例如 `type gs`

##### 常用

```bash
alias d='dirs -l -v'
alias p='pushd'
alias po='popd'

alias j='jobs'

alias l='ls'
alias l.='ls -d .* --color=auto'
alias ll='ls -lh'

alias le='less'
alias md='mkdir'
alias rp='realpath'
alias wh='which'
alias f='find . -name'
alias gr='g -r -n'

alias vb='vim ~/.bashrc'
alias sb='source ~/.bashrc'
alias vv='vim ~/.vimrc'

# other
alias du.='for f in * ; do du -sh $f; done | sort -h'
```

#### git 相关
* `gs`: git status

```bash
alias ga='git add'
alias gb='git branch'
alias gc='git checkout'
alias gd='git d'
alias gdd='git diff'
alias gl='git log'
alias gm='git commit'
alias gma='git commit --amend'
alias gp='git pull'
alias gpu='git push'
```
#### 代理相关

* `sp`: Set Proxy
* `spho`: Set Proxy HOst
* `splo`: Set Proxy LO
* `tp`: Test Proxy
* `up`: Unset Proxy

#### svn

```bash
alias sa='svn add'
alias sd='svn diff'
alias si='svn propedit svn:ignore'
alias sll='svn log -v | less'
alias sm='svn commit'
alias sr='svn rm'
alias ss!='svn status | grep "^\!" | tr "^\!" " " | sed "s/[ ]*//" | sed "s/[ ]/\\\ /g"'
alias ss?='svn status | grep "^\?" | tr "^\?" " " | sed "s/[ ]*//" | sed "s/[ ]/\\\ /g"'
alias ss_='svn status'
alias ssa='ss? | xargs svn add'
alias ssr='ss! | xargs svn rm'
alias su_='svn update'
```

##### 安全

```bash
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
```

#### 其他

* `t`: use Tmux quickly
* `urldecode`
* `urlencode`
* `green`: 绿色输出文本
* `red`: 红色输出文本
* `yellow`: 黄色输出文本
* `hg`: xxx --help |grep xxx
* `hig`: history grep
