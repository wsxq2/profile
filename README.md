# MyProfile


## 说明
这是我在 Linux 中使用的各种配置文件，例如`~/.bashrc`, `~/.vimrc`等等

建议 fork 到自己的仓库，再按需修改，并自行维护（毕竟每个人的需求是不一样的）


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

## 函数
* `green`: 绿色输出文本
* `red`: 红色输出文本
* `yellow`: 黄色输出文本
* `grrules`: 根据关键字抓取 IPS 规则
* `grsid`: 根据 sid 抓取 IPS 规则
* `gs`: git status
* `gsm`: git status Tracked
* `gsu`: git status Untracked
* `hg`: xxx --help |grep xxx
* `hig`: history grep
* `install_tmux`: 安装 tmux
* `install_tpm`: 安装 tmux 的 tpm 插件
* `install_vim8`: 安装 vim8
* `mi`: MInicom。用于在终端连接串口
* `pg`: Ps Grep。
* `random_port`: 获取随机端口
* `random_string`: 获取随机字符串
* `sp`: Set Proxy
* `spho`: Set Proxy HOst
* `splo`: Set Proxy LO
* `tp`: Test Proxy
* `up`: Unset Proxy
* `t`: use Tmux quickly
* `urldecode`
* `urlencode`
* `vdd`: Vim Dir Diff
* `vfp`: vim Find Path
* `wait_host_service`: 等待某个主机的某个服务可用。如 10.12.1.77 的 22 号端口。通常用于等待设备重启 

## 别名

#### git
```bash
alias g='grep -I --exclude-dir=.git'
alias ga='git add'
alias ga.='gss | xargs git add'
alias gb='git branch'
alias gbh='git rev-parse --abbrev-ref HEAD'
alias gc='git checkout'
alias gd='git d'
alias gdd='git diff'
alias gl='git log'
alias gm='git commit'
alias gma='git commit --amend'
alias gmm='git commit -m'
alias gp='git pull'
alias gph='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gpu='git push'
alias gss='git status --short'
alias gt='git tag'
alias gv='git rev-parse --short HEAD'
alias vig='vim .gitignore'
```

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

#### 安全
```bash
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
```

#### 常用
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

## 一些使用样例
```bash
# 目录切换
p $mp
p ~
d
po
po
```
