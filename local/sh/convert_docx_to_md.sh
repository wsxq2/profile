#!/bin/bash
#
# 将我写的 DOCX 转换为 MD 文件
#

# 当命令返回非 0 或使用未设置变量时强行退出
set -eu

# 调试开关（显示执行的命令）
set -x


set_code_style()
{
    python3 - <<EOF
import docx
document = docx.Document('$1')
if '代码' in document.styles:
    document.styles['代码'].name='Source Code'
document.save('$2')
EOF
}
execute_pandoc(){
    pandoc --extract-media=$docx_basename --shift-heading-level-by=1 -p --tab-stop=4 -s --wrap=none -f docx -t gfm+attributes+definition_lists+tex_math_dollars -o "$2" "$1"
}
fix_image_url(){
    sed -r -i 's#!\[[^]]*\]\(([^/]+)/media/(.+\.(gif|jpg|jpeg|png))\)#![\2](http://wsxq12.55555.io/\1/\2)#g' "$1"
    sed -r -i 's/\{width="[0-9]+\.[0-9]+in" height="[0-9]+\.[0-9]+in"\}//g' "$1"
}
fix_quote(){
    sed -r -i 's/^> > /> /' "$1"
}

fix_changelog(){
    sed -r -i -e 's/00195-王志强/wsxq2/g' -e '/温馨提示：此处记录的是比较大的更新，如果只是纠正了几个错别字就不用写在这里了/d' "$1"
}

fix_head(){
    sed -ri -e '1,/^## $/{d}' "$1"
}

mv_image(){
    [[ -d $docx_basename ]] || return 0
    [[ -d $docx_basename/media ]] || return 0
    mv $docx_basename/media/* $docx_basename
    rm -rf $docx_basename/media
    rm -rf $bl/images/$docx_basename && mv $docx_basename $bl/images
}

fix_converted_md(){
    local md="$1"
    fix_image_url $md
    fix_quote $md
    fix_changelog $md
    fix_head $md
}

add_content(){
    if grep '^last_modified_time:' "$1" &> /dev/null; then
        return 0
    fi
    cat - "$1" > new.md <<EOF
---
tags: [FROM_DOCX]
last_modified_time: $(date +'%F %T') +0800
title: $docx_basename_with_space
---


<p id="markdown-toc"></p>
<!-- vim-markdown-toc GFM -->

<!-- vim-markdown-toc -->

EOF
    mv new.md "$1"

}

main(){
    local md docx
    docx="$1"
    docx_basename_with_space=$(basename ${docx%.*})
    docx_basename=${docx_basename_with_space// /-}

    local tested_md=$bl/*-${docx_basename}.md
    [[ -f $tested_md ]] && md="$tested_md" || md="$bl/$(date +%F)-${docx_basename}.md"
    [[ -z ${2+x} ]] || md="$2"
    

    pushd $TMPFILE
    set_code_style $docx handled.docx
    execute_pandoc handled.docx $md
    fix_converted_md $md
    add_content $md
    mv_image
    popd
}

color_echo()
{
    local color
    color="$1"
    shift
    echo -e '\033['"$color"'m'"$@"'\033[0m'
}
green()
{
    color_echo '1;32' "$@"
}
blue()
{
    color_echo '0;36' "$@"
}
yellow()
{
    color_echo '1;33' "$@"
}
red()
{
    color_echo '1;31' "$@"
}



convert_all_in_dir(){
    SAVEIFS=$IFS
    IFS=$(echo -en "\n\b")
    for f in /mnt/c/Users/wsxq2/OneDrive/文档/个人文档输出/*.docx
    do
        main "$f" || yellow "$f"
    done |& tee a.log
    IFS=$SAVEIFS
}

TMPFILE="$(mktemp -dt convert_docx_to_md_sh.XXXXXX)"
trap "rm -rf '$TMPFILE'" 0               # EXIT
trap "rm -rf '$TMPFILE'; exit 1" 2       # INT
trap "rm -rf '$TMPFILE'; exit 1" 1 15    # HUP TERM

convert_all_in_dir
