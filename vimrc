" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
"runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Source a global configuration file if available
"if filereadable("/etc/vim/vimrc.local")
"  source /etc/vim/vimrc.local
"endif

if has("autocmd")
    " Uncomment the following to have Vim load indentation rules and plugins
    " according to the detected filetype.
    filetype plugin indent on
    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

"for debug
"set verbose=9

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
"set smartcase      " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
"set hidden     " Hide buffers when they are abandoned
"set mouse=a        " Enable mouse usage (all modes)
set tabstop=4
set helplang=en
set hlsearch
set scrolloff=10
set autoindent
set nocompatible
"set backup
"set backupext=.bak
"set patchmode=.orig
set history=500
set ruler
"set iskeyword+=-
set wrap
set sidescroll=10
set showmode
set matchpairs&
set wrapscan
set nolist
"set cmdheight=3
set autowrite
set noscrollbind
set laststatus=1
set shiftwidth=4
set updatecount=200
set updatetime=4000
set directory&
set pastetoggle=<F9>

set showcmd             " Show (partial) command in status line.
set keywordprg=:Man
set bs=indent,eol,start

set nosplitbelow
set nosplitright

" Enable folding
set foldmethod=indent
set foldlevel=99
set nonu
set encoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

set expandtab
" set cursorline

:runtime! ftplugin/man.vim



"VIM: 括号自动补全
""inoremap ( ()<LEFT>
""inoremap [ []<LEFT>
""inoremap { {}<LEFT>
""inoremap " ""<LEFT>
""inoremap ' ''<LEFT>
""""inoremap < <><LEFT>
""
""function! RemovePairs()
""    let s:line = getline(".")
""    let s:previous_char = s:line[col(".")-1]
""
""    if index(["(","[","{"],s:previous_char) != -1
""        let l:original_pos = getpos(".")
""        execute "normal %"
""        let l:new_pos = getpos(".")
""        " only right (
""        if l:original_pos == l:new_pos
""            execute "normal! a\<BS>"
""            return
""        end
""
""        let l:line2 = getline(".")
""        if len(l:line2) == col(".")
""            execute "normal! v%xa"
""        else
""            execute "normal! v%xi"
""        end
""    else
""        execute "normal! a\<BS>"
""    end
""endfunction
""
""function! RemoveNextDoubleChar(char)
""    let l:line = getline(".")
""    let l:next_char = l:line[col(".")]
""
""    if a:char == l:next_char
""        execute "normal! l"
""    else
""        execute "normal! a" . a:char . ""
""    end
""endfunction
""
""inoremap <BS> <ESC>:call RemovePairs()<CR>a
""inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
""inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
""inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a
""inoremap > <ESC>:call RemoveNextDoubleChar('>')<CR>a

""vimim（VIM 内嵌中文输入法）
"let g:Vimim_cloud = 'baidu'
"let g:Vimim_mode = 'dynamic'
"let g:Vimim_mycloud = 0
"let g:Vimim_punctuation = 3
"" 1  基本中文标点
"" 2  常用中文标点（缺省）
"" 3  包括单双引号反斜杠
"" 0  不用中文标点
"" -1 彻底关闭中文标点
"let g:Vimim_shuangpin = 0
""let g:Vimim_toggle = 'pinyin,google,sogou'
""let g:Vimim_map = 'tab_as_gi'
""let g:Vimim_plugin = 'C:/var/mobile/vim/vimfiles/plugin'

"autocmd cursorhold * set nohlsearch

"Automatic install vim-plug
"Place the following code in your .vimrc before plug#begin() call
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    if v:shell_error ==# 0
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    "Note that --sync flag is used to block the execution until the installer finishes.
    "(If you're behind an HTTP proxy, you may need to add --insecure option to the curl command.
    "In that case, you also need to set $GIT_SSL_NO_VERIFY to true.)
else
    "Vim-plug
    "Unlike Vundle, vim-plug does not implicitly prepend vim-scripts/ to single-segment argument.
    "So Plugin 'taglist.vim' in Vundle should be explicitly written as Plug 'vim-scripts/taglist.vim'.
    "However, note that vim-scripts.org is no longer maintained.
    call plug#begin('~/.vim/bundle') "change plugged to bundle to avoid reinstalling plugins
    "If you need Vim help for vim-plug itself (e.g. :help plug-options), register vim-plug as a plugin.
    Plug 'mfukar/robotframework-vim',{'frozen':1}
    Plug 'junegunn/vim-plug',{'frozen':1}
    "符号配对，如()
    Plug 'Raimondi/delimitMate',{'frozen':1}
    " vim 中文文档
    " Plug 'yianwillis/vimcdoc'
    " "中文输入法
    " Plug 'vim-scripts/VimIM'
    Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown', 'frozen':1}
    Plug 'dhruvasagar/vim-table-mode', { 'for': ['markdown','robot'], 'frozen':1}
    Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'xml', 'php', 'markdown'], 'frozen':1}
    if $ENABLE_YCM ==# 1
        Plug 'Valloric/YouCompleteMe', { 'do': 'sp && ./install.py --clang-completer --java-completer && up' ; 'frozen': 1}
    endif
    if has('python3')
        Plug 'SirVer/ultisnips', {'frozen': 1}
    elseif has('python')
        Plug 'SirVer/ultisnips', {
                    \   'tag': '3.2',
                    \   'dir': get(g:, 'plug_home', '~/.vim/bundle') . '/ultisnips_py2',
                    \ 'frozen': 1,
                    \ }
    endif
    "常用的 snippets
    Plug 'honza/vim-snippets', {'frozen': 1}
    "display the indention levels with thin vertical lines
    Plug 'Yggdroot/indentLine', {'frozen':1}
    "python format
    Plug 'tell-k/vim-autopep8', {'for': ['python'], 'frozen': 1}
    "sql format
    Plug 'vim-scripts/dbext.vim', {'for': ['sql'], 'frozen':1}
    Plug 'Chiel92/vim-autoformat',{'frozen':1}
    Plug 'huleiak47/vim-AHKcomplete',{'for': ['ahk'], 'frozen': 1}
    Plug 'will133/vim-dirdiff',{'frozen': 1}
    "autohotkey syntax highlighting
    "Plug 'vim-scripts/autohotkey-ahk',{'frozen': 1}
    "Vim configuration files for AutoHotkey code
    Plug 'hnamikaw/vim-autohotkey',{'for': ['ahk'], 'frozen': 1}
    Plug 'preservim/tagbar', {'frozen':1}
    " 中文编码问题
    Plug 'mbbill/fencview', {'frozen':1}

    " for git
    "Plug 'tpope/vim-fugitive'
    Plug 'zivyangll/git-blame.vim'

    "Plug 'brookhong/cscope.vim', {'frozen':1}

    if has('nvim')
        Plug 'neovim/nvim-lspconfig'
        "Plug 'kabouzeid/nvim-lspinstall'
    endif

    " for pandoc
    "Plug 'vim-pandoc/vim-pandoc-syntax'
    "Plug 'vim-pandoc/vim-pandoc'


    " Plug 'ervandew/supertab' " YCM has contain its all functions, so turn off it
    " Plug 'pangloss/vim-javascript'

    "Alternatively, you can pass an empty on or for option so that the plugin is registered but not loaded by default depending on the condition.
    "Plug 'benekastah/neomake', has('nvim') ? {} : { 'on': [] }
    "vim-plug does not natively support installing small Vim plugins from Gist. But there is a workaround if you really want it.
    "Plug 'https://gist.github.com/952560a43601cd9898f1.git',
    "    \ { 'as': 'xxx', 'do': 'mkdir -p plugin; cp -f *.vim plugin/' }
    "Loading plugins manually
    "With on and for options, vim-plug allows you to defer loading of plugins.
    "But if you want a plugin to be loaded on an event that is not supported by vim-plug, you can set on or for option to an empty list,
    "and use plug#load(names...) function later to load the plugin manually. The following example will load ultisnips and YouCompleteMe first time you enter insert mode.
    "
    "" Load on nothing
    "Plug 'SirVer/ultisnips', { 'on': [] }
    "Plug 'Valloric/YouCompleteMe', { 'on': [] }
    "
    "augroup load_us_ycm
    "  autocmd!
    "  autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe')
    "                     \| autocmd! load_us_ycm
    "augroup END

    call plug#end()

    " emmet
    " let g:user_emmet_expandabbr_key = 'c-s'
    let g:user_emmet_settings = {
                \ 'css': {
                    \        'snippets': {
                        \           "bdc": "border-color:|;",
                        \           "bgc": "background-color:|;",
                        \           "c": "color:|;",
                        \        },
                        \ },
                        \ 'html' : {
                            \       'snippets': {
                                \      'html:5': "<!DOCTYPE html>\n"
                                \              ."<html lang=\"${lang}\">\n"
                                \              ."<head>\n"
                                \              ."\t<meta charset=\"${charset}\" />\n"
                                \              ."\t<title></title>\n"
                                \              ."</head>\n"
                                \              ."<body>\n\t|\n</body>\n"
                                \              ."</html>",
                                \   },
                                \   'expandos': {
                                    \   },
                                    \   'default_attributes': {
                                        \         'link': [{'rel': '|'}, {'href': ''}],
                                        \       },
                                        \       'empty_element_suffix': ' />',
                                        \ },
                                        \}

    "makes the "%" command jump to matching HTML tags, if/else/endif in Vim scripts, etc
    "packadd! matchit
    runtime macros/matchit.vim

    " for ycm
    if $ENABLE_YCM ==# 1
        let g:ycm_min_num_identifier_candidate_chars = 4
        "开始补全的字符数"
        let g:ycm_min_num_of_chars_for_completion = 2 "set 99 to turn off identifiers completer
        let g:ycm_max_num_identifier_candidates = 10 "identifier completion
        let g:ycm_max_num_candidates = 30 "semantic completion
        let g:ycm_auto_trigger = 1
        let g:ycm_key_list_stop_completion = ['<C-y>']
        "python解释器路径"
        let g:ycm_server_python_interpreter='/root/.pyenv/shims/python'
        let g:ycm_python_binary_path = '/root/.pyenv/shims/python'
        "默认配置文件路径"
        let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
        let g:ycm_error_symbol = '>>'
        let g:ycm_warning_symbol = '>'
        let g:ycm_key_invoke_completion = '<c-l>'
        "打开vim时不再询问是否加载ycm_extra_conf.py配置"
        let g:ycm_confirm_extra_conf=0
        set completeopt=longest,menu
        "set completeopt=preview,menuone
        " 关闭自动弹出的函数原型预览窗口
        "set completeopt=menu,menuone
        " let g:ycm_add_preview_to_completeopt = 0
        "是否开启语义补全"
        let g:ycm_seed_identifiers_with_syntax=1
        " 关闭YCM的诊断信息，这样就可以使用其他静态检查插件
        let g:ycm_show_diagnostics_ui = 0
        " 开启 YCM 标签补全引擎
        let g:ycm_collect_identifiers_from_tags_files=1
        " 修改高亮的背景色, 适应主题
        " highlight SyntasticErrorSign guifg=white guibg=black

        " to see error location list
        "let g:syntastic_always_populate_loc_list = 0
        "let g:syntastic_auto_loc_list = 0
        "let g:syntastic_loc_list_height = 5
        "function! ToggleErrors()
        "    let old_last_winnr = winnr('$')
        "    lclose
        "    if old_last_winnr == winnr('$')
        "        " Nothing was closed, open syntastic error location panel
        "        Errors
        "    endif
        "endfunction
        "nnoremap <Leader>s :call ToggleErrors()<cr>
        " nnoremap <Leader>sn :lnext<cr>
        " nnoremap <Leader>sp :lprevious<cr>

        " https://zhuanlan.zhihu.com/p/33046090
        " 避免编辑白名单外的文件类型时 YCM 也一直分析
        let g:ycm_filetype_whitelist = {
                    \ "java":1,
                    \ "javascript": 1,
                    \ "php":1,
                    \ "c":1,
                    \ "sh":1,
                    \ "python":1,
                    \ "sql":1,
                    \ "make":1,
                    \ }


        "let g:syntastic_check_on_open=1
        "let g:syntastic_check_on_wq=0
        "let g:syntastic_enable_highlighting=1
        "let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
        "let g:syntastic_javascript_checkers = ['jsl', 'jshint']
        "let g:syntastic_html_checkers=['tidy', 'jshint']

        "是否在注释中也开启补全"
        let g:ycm_complete_in_comments=1
        "字符串中也开启补全"
        let g:ycm_complete_in_strings = 1
        let g:ycm_collect_identifiers_from_comments_and_strings = 0
        "补全后自动关机预览窗口"
        let g:ycm_autoclose_preview_window_after_completion=1
        " 禁止缓存匹配项,每次都重新生成匹配项"
        let g:ycm_cache_omnifunc=0

        "let g:ycm_log_level = 'debug'
        nnoremap <leader>fi :YcmCompleter FixIt<CR>
        nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
        "for C language
        nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
        nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
        nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
        nnoremap <leader>gg :YcmCompleter GoTo<CR>
        nnoremap <leader>gt :YcmCompleter GetType<CR>
        nnoremap <leader>gp :YcmCompleter GetParent<CR>
        nnoremap <leader>gd :YcmCompleter GetDoc<CR>
        nmap <leader>y :YcmDiags<CR>


        "离开插入模式后自动关闭预览窗口"
        " autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    endif

    " UltiSnips
    let g:UltiSnipsEditSplit = 'vertical'
    let g:UltiSnipsExpandTrigger         =     '<c-j>'
    let g:UltiSnipsListSnippets          =     '<F2>'
    let g:UltiSnipsJumpForwardTrigger    =     '<c-j>'
    let g:UltiSnipsJumpBackwardTrigger   =     '<c-b>'
    let g:UltiSnipsEnableSnipMate = 1
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips', $HOME.'/.vim/bundle/vim-snippets/UltiSnips']
    let g:snips_author = 'wsxq2'
    nnoremap <leader>ue :UltiSnipsEdit!<CR>

    "缩进指示线"
    let g:indentLine_char='┆'
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    "let g:indentLine_enabled = 0
    let g:indentLine_fileType = ['c', 'cpp']
    nnoremap <leader>i :IndentLinesToggle<CR>

    "autopep8设置"
    "let g:autopep8_disable_show_diff=1
    "let g:autopep8_on_save = 1


    "for vim-autoformat
    "let g:autoformat_verbosemode=1
    "autocmd BufWrite *.sql,*.c,*.py,*.java,*.js :Autoformat
    noremap <leader>a :Autoformat<CR>
    let g:formatdef_sqlformat = '"sqlformat --keywords upper -"'
    let g:formatters_sql = ['sqlformat']
    let g:formatdef_clangformat_file = '"clang-format -style file -lines=".a:firstline.":".a:lastline." -"'
    let g:formatters_c = ['clangformat_file']
    let g:formatters_cpp = ['clangformat_file']
    let g:formatdef_astyle_java = '"astyle --mode=java --style=java -pcHt"'
    let g:formatters_java = ['astyle_java']

    "let g:autoformat_autoindent = 0
    "let g:autoformat_retab = 0
    "let g:autoformat_remove_trailing_spaces = 0
    "autocmd FileType vim,tex let b:autoformat_autoindent=0
    "gg=G :retab :RemoveTrailingSpaces


    "for vim-markdown-toc
    let g:vmt_fence_hidden_markdown_style = 'GFM'

    "for vim-table-mode
    let g:table_mode_auto_align = 0
    let g:table_mode_corner = '|'

endif

vnoremap // y/<c-r>"<cr>

" fold
"nnoremap <space> za

" Edit my Vimrc file
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>eV :vsplit $MYVIMRC<cr>
" Edit my bashrc file
nnoremap <leader>eb :vsplit ~/.bashrc<cr>
" Source my Vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>
" 编辑 Vim 使用笔记
nnoremap <leader>env :vsplit $bl/2018-11-25-Vim使用笔记.md<cr>
" 编辑 Bash 使用笔记
nnoremap <leader>enb :vsplit $bl/2018-11-05-Bash使用笔记.md<cr>
" 编辑 markdown 文件的代码片段
nnoremap <leader>em :vsplit ~/.vim/UltiSnips/markdown.snippets<cr>
" Make
nnoremap <F3> :qa<CR>
"nnoremap <F4> :wa<CR>
nnoremap <F5> :!cscope -Rbkq; ctags -R --languages=C,C++<CR>:cs reset<CR><CR>
nnoremap <F6> :make<CR>
nnoremap <F7> :!cd $pb/; make dp DEBUGFLAG=debug D=1<CR>
nnoremap <F8> :TagbarToggle<CR>
" recovery window
" nnoremap <C-w>o :mksession! ~/.vim/session.vim<CR>:wincmd o<CR>
" nnoremap <C-w>u :source ~/.vim/session.vim<CR>

inoremap jk <esc>
"inoremap <Up> <nop>
"inoremap <Down> <nop>
"inoremap <right> <nop>
"inoremap <left> <nop>

iabbrev adn and
iabbrev waht what
iabbrev tehn then
iabbrev w@ wsxq2@qq.com
iabbrev wg@ wsxq222222@gmail.com
iabbrev co@ Copyright 2020 wsxq2, all rights reserved.

command! -range Rh <line1>,<line2>s/&/\&amp;/ge | <line1>,<line2>s/</\&lt;/ge | <line1>,<line2>s/>/\&gt;/ge | <line1>,<line2>s/^\(\s*\)```\(\_.\{-1,}\)```$/\1<pre>\2<\/pre>/e

augroup CommonFile
    au!
    autocmd FileType text setlocal textwidth=80 fo=tcqmM noai
    autocmd FileType markdown,html,c,vimrc,yaml setlocal expandtab ts=4 sw=4
    autocmd FileType xml,html,css setlocal iskeyword+=-
    " for vim-AHKcomplete
    autocmd FileType autohotkey setlocal omnifunc=ahkcomplete#Complete
    autocmd FileType robot let g:table_mode_auto_align = 0
    autocmd BufReadPre *.wxml setlocal filetype=xml
augroup END

augroup mdFile
    au!
    autocmd FileType markdown nnoremap <leader>p /## 遇到过的问题<CR>
    autocmd FileType markdown let @e='i`ea`'
    autocmd FileType markdown let @s='i ea '
    autocmd FileType markdown let @l=':/^<!-- link start -->/+1,/^<!-- link end -->/-1 g!/^$/d:let @t="":1,/^<!-- vim-markdown-toc GFM -->/ s/[^!]\(\[.\{-1,}\](http[^[\]]\{-1,})\)/\=setreg("T","* ".submatch(1),"l")/egn:/^<!-- vim-markdown-toc -->/,/^<!-- link start -->/ s/[^!]\(\[.\{-1,}\](http[^[\]]\{-1,})\)/\=setreg("T","* ".submatch(1),"l")/egn:1,/^<!-- vim-markdown-toc GFM -->/ s/[^!]\?\(\[[^]]\+\]\[[^]]\{-1,}\]\)/\=setreg("T","* ".submatch(1),"l")/egn:/^<!-- vim-markdown-toc -->/,/^<!-- link start -->/ s/[^!]\?\(\[[^]]\+\]\[[^]]\{-1,}\]\)/\=setreg("T","* ".submatch(1),"l")/egn/<!-- link start -->"tp:/^<!-- link start -->/+1,/^<!-- link end -->/-1 sort u'
    autocmd FileType markdown let @q='I`<kEnd>`<Esc>'
    autocmd FileType markdown let @m=':.s/\(\d\+\)-\(\d\+\)-\(\d\+\)-\([^.]\+\)\.md/[\4](https:\/\/wsxq2.55555.io\/blog\/\1\/\2\/\3\/\4)/'
    autocmd FileType markdown let @p=':%s/<!--picture \([^ ]\+\) -->/![\1](http:\/\/wsxq12.55555.io\/\1)/g'
    autocmd FileType markdown let @a=':/^<!-- abbreviations end -->/+1,$ g!/^$/d:let @t="":/^<!-- vim-markdown-toc -->/,/^<!-- link start -->/ s/\C[^%]\([A-Z]\{2,}\)\>/\=setreg("T",submatch(1),"l")/egn/^<!-- abbreviations end -->"tp:/^<!-- abbreviations end -->/+1,$ sort u:/^<!-- abbreviations end -->/+1,$ !$bl/handle-abbreviations.sh'
    autocmd FileType markdown let @b=':/^<!-- abbreviations start -->/+1,/^<!-- abbreviations end -->/-1 d:/^<!-- abbreviations end -->/+1,$ co /^<!-- abbreviations start -->/:/^<!-- abbreviations start -->/+1,/^<!-- abbreviations end -->/-1 s/\*\[\([^]]\+\)]:\(.\+\)$/* **\1**:\2/'
    autocmd FileType markdown let @k=':s/\(^[^[].\+\): \(http.*\)$/[\1](\2)/:s/|/｜/ge'
augroup END

function! s:AddTime(fileType)
    if a:fileType ==? 'md'
        if getline(2) =~ '^tags:.*$'
            if getline(3) =~ '^last_modified_time: .*$'
                execute 'silent 3s/^last_modified_time: \zs.*\ze$/\=strftime("%Y-%m-%d %H:%M:%S %z")/ | normal ``'
            else
                call append(2,"last_modified_time: ".strftime('%Y-%m-%d %H:%M:%S %z'))
            endif
        endif
    elseif a:fileType ==? 'php'
        "execute 'silent %s#^// | 上次修改时间\(: \|：\)\zs.*\ze$#\=strftime("%Y-%m-%d %H:%M:%S %z")#eg | normal ``'
    endif
endfunction

" edit blog auto add datetime
augroup insert_datetime
    au!
    autocmd BufWritePre *.md call s:AddTime('md')
    autocmd BufWritePre *.php call s:AddTime('php')
augroup END

" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufReadPre   *.bin,*.com,*.COM,*.exe,*.EXE,*.img,*.IMG,*.o,*.out let &bin=1
    au BufReadPost  *.bin,*.com,*.COM,*.exe,*.EXE,*.img,*.IMG,*.o,*.out if &bin | silent %!xxd
    au BufReadPost  *.bin,*.com,*.COM,*.exe,*.EXE,*.img,*.IMG,*.o,*.out set ft=xxd | endif
    au BufWritePre  *.bin,*.com,*.COM,*.exe,*.EXE,*.img,*.IMG,*.o,*.out if &bin | silent %!xxd -r
    au BufWritePre  *.bin,*.com,*.COM,*.exe,*.EXE,*.img,*.IMG,*.o,*.out endif
    au BufWritePost *.bin,*.com,*.COM,*.exe,*.EXE,*.img,*.IMG,*.o,*.out if &bin | silent %!xxd
    au BufWritePost *.bin,*.com,*.COM,*.exe,*.EXE,*.img,*.IMG,*.o,*.out set nomod | endif
augroup END

set isfname-==

"vimdiff 配色问题解决方法
"方法一
"" 新增的行 "
"highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"" 删除的行 "
"highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"" 差异的行 "
"highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"" 差异的文字 "
"highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
"
function MyDiff()
    let opt = ""
    if &diffopt =~ "icase"
        let opt = opt . "-i "
    endif
    if &diffopt =~ "iwhite"
        let opt = opt . "-b -w -B "
    endif
    silent execute "!diff -a --binary " . opt . v:fname_in . " " . v:fname_new .
                \  " > " . v:fname_out
    redraw!
endfunction

function! IwhiteToggle()
    if &diffopt =~ 'iwhite'
        set diffopt-=iwhite
    else
        set diffopt+=iwhite
    endif
endfunction

if &diff
    "方法二
    colorscheme evening
    "方法三
    "syntax off
    map gs :call IwhiteToggle()<CR>
    set diffopt+=algorithm:minimal
    set diffexpr=MyDiff()
    call IwhiteToggle()
endif
augroup Diff
    au!
    au FilterWritePre * if &diff|colorscheme evening|map gs :call IwhiteToggle()<CR>|set diffopt+=algorithm:minimal|set diffexpr=MyDiff()|call IwhiteToggle()|endif
augroup END
" 方法四
" Fix the difficult-to-read default setting for diff text highlighting.  The
" " bang (!) is required since we are overwriting the DiffText setting. The
" highlighting for "Todo" also looks nice (yellow) if you don't like the "MatchParen"
" colors.
" highlight! link DiffText MatchParen

"pythonthreehome=...

" cscope setting ( refer to h :cs )
function! PrepareCscope()
    if has("cscope") && (! &diff)
        set csprg=/usr/bin/cscope              "指定用来执行 cscope 的命令
        set csto=1                             "先搜索tags标签文件，再搜索cscope数据库
        set cst                                "使用`:cstag`(:cs find g)，而不是缺省的:tag
        set nocsverb                           "不显示添加数据库是否成功
        "添加cscope数据库
        if filereadable("cscope.out")
            cs add cscope.out
        elseif filereadable($mcp."/"."cscope.out")
            cs add $mcp/cscope.out $mcp
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
        set csverb                             "显示添加成功与否

        "cscope -Rbkq, ctags -R
        "map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
        "map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
        "
        "a: 查找赋值的地方
        nnoremap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>
        "s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
        nnoremap gs :cs find s <C-R>=expand("<cword>")<CR><CR>
        "g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
        nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
        "d: 查找本函数调用的函数
        nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
        "c: 查找调用本函数的函数
        nnoremap gc :cs find c <C-R>=expand("<cword>")<CR><CR>
        "t: 查找指定的字符串
        nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
        "e: 查找egrep模式，相当于egrep功能，但查找速度快多了
        nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
        "f: 查找并打开文件，类似vim的find功能
        nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
        "i: 查找包含本文件的文件
        nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    endif
endfunction
augroup cFile
    au!
    autocmd FileType c,cpp call PrepareCscope()
    autocmd filetype c,cpp nnoremap <buffer><leader>t :let @t=''<CR> :%s/^static void \(TEST_F(\w\+)\)$/\=setreg("T", submatch(1).";\n")/gn<CR>
    autocmd filetype c,cpp nnoremap <buffer><leader>d :let @t=''<CR> :%s/^\w\+\( \w\+\)\+(\(\\|[^,]\+\(, *[^,]\+\)*\))$/\=setreg("T", submatch(0).";\n")/gn<CR>
augroup END
"nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
"nnoremap <leader>l :call ToggleLocationList()<CR>
"" s: Find this C symbol
"nnoremap  <leader>s :call CscopeFind('s', expand('<cword>'))<CR>)
""let g:cscope_preload_path="/usr/include/"
"let g:cscope_ignored_dir = '.git$'
"let g:cscope_interested_files = '\.c$\|\.cpp$\|\.h$\|\.hpp'
"let g:cscope_silent = 1
"let g:cscope_open_location = 0

"for dirdiff
let g:DirDiffExcludes = "CVS,*.class,*.o,*.out,upload,*.swp,*.swo"
let g:DirDiffIgnore = "Id:"
" ignore white space in diff
let g:DirDiffAddArgs = "-w"
let g:DirDiffEnableMappings = 1


" window change
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>
nmap <silent> <A-k> :wincmd k<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>

" hi Search ctermfg=Red

colorscheme desert

" for fencview
"let g:fencview_autodetect = 1
"let g:fencview_auto_patterns='*.txt, *.html{l\=}'
"let g:fencview_checklines=10
"$FENCVIEW_TELLENC=tellenc

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:`
nnoremap <leader>l :set list<CR>
nnoremap <leader>L :set nolist<CR>

function! ClangCheckImpl(cmd)
    if &autowrite | wall | endif
    echo "Running " . a:cmd . " ..."
    let l:output = system(a:cmd)
    cexpr l:output
    cwindow
    let w:quickfix_title = a:cmd
    if v:shell_error != 0
        cc
    endif
    let g:clang_check_last_cmd = a:cmd
endfunction

function! ClangCheck()
    let l:filename = expand('%')
    if l:filename =~ '\.\(cpp\|cxx\|cc\|c\)$'
        call ClangCheckImpl("clang-check " . l:filename)
    elseif exists("g:clang_check_last_cmd")
        call ClangCheckImpl(g:clang_check_last_cmd)
    else
        echo "Can't detect file's compilation arguments and no previous clang-check invocation!"
    endif
endfunction

nmap <silent> <F4> :call ClangCheck()<CR><CR>
inoremap <c-v> <nop>

" for git
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>

