#!/bin/bash
#
# 将 MD 转换为 DOCX
#

# 当命令返回非 0 或使用未设置变量时强行退出
set -eu

# 调试开关（显示执行的命令）
#set -xv

usage(){
    cat <<EOF
Usage: $0 <md_file> <docx_file>
EOF
}

execute_pandoc(){
    pandoc --lua-filter read_html.lua --reference-doc=/mnt/c/Users/wsxq2/Downloads/custom-reference.docx --shift-heading-level-by=-1 -p --tab-stop=4 -s --wrap=none --toc --toc-depth=3 --strip-comments --highlight-style=pygments -N -f gfm+attributes+definition_lists+tex_math_dollars -t docx -o "$2" "$1"
}

#set_table_style(){
#    7z.exe x $1 word/document.xml
#    sed -i "s/<w:tblStyle w:val=\"TableNormal\"/<w:tblStyle w:val=\"NewTableStyle\"/g" word/document.xml
#    7z.exe u $1 word/document.xml
#}

set_table_style(){
    python3 <<EOF
import docx
document = docx.Document('$1')
for table in document.tables:
    print(table)
    table.style = document.styles['TableNormal'] # custom_style must exist in your reference.docx file
document.save("$1")
EOF
}

prepare_html_filter()
{
    cat <<EOF >read_html.lua
function RawBlock (raw)
  if raw.format:match 'html' and not FORMAT:match 'html' then
    return pandoc.read(raw.text, raw.format).blocks
end
end
EOF
}

test1(){
    execute_pandoc /mnt/c/Users/wsxq2/Documents/MY/workspace/wsxq2.github.io/_posts/2019-08-18-C语言笔记.md /mnt/c/Users/wsxq2/Downloads/c.docx
    set_table_style /mnt/c/Users/wsxq2/Downloads/c.docx
}
test2(){
    execute_pandoc /mnt/c/Users/wsxq2/Documents/MY/workspace/wsxq2.github.io/_posts/2022-03-12-pandoc_test.md $dow/pandoc_test.docx
    set_table_style $dow/pandoc_test.docx
}

main()
{
    local md docx
    md="$1"
    docx="${2:-${md%.*}.docx}"
    execute_pandoc $md $docx
    set_table_style $docx

}

prepare_html_filter
#"$@"
main "$@"
