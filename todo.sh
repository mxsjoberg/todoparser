#!/bin/sh

c_none="\033[0m"
c_cyan="\033[0;36m"
c_yellow="\033[0;33m"
b_cyan="\033[1;36m"

if [ $# -eq 0 ];
then
    # .todo to add files to search in (this works better than ignore, too much garbage in most repos)
    if test -f .todo; then
        # echo "${b_cyan}$0${c_cyan}: ${b_cyan}.todo${c_cyan} found${c_none}"
        # echo "${b_cyan}$0${c_cyan}: search only in file -> todo <file>${c_none}\n"
        echo ""
        for file in $(cat .todo)
        do
            echo "${c_yellow}$file${c_none}" "$(wc -l < "$file") lines"
            grep -F -n "# TODO" $file | sed 's/:[[:blank:]]*/: /' | sed "s/# TODO//" | perl -ne 'print "  $_"'
        done
    else
        echo "${b_cyan}$0${c_cyan}: ${b_cyan}.todo${c_cyan} not found (create it manually or 'todo init')${c_none}"
        # echo "${b_cyan}$0${c_cyan}: create it manually or 'todo init'${c_none}"
    fi
else
    # todo init -> to create .todo
    if [ $1 = "init" ];
    then
        if [ ! -f .todo ];
        then
            touch .todo
            echo "${b_cyan}$0${c_cyan}: ${b_cyan}.todo${c_cyan} created${c_none}"
        else
            echo "${b_cyan}$0${c_cyan}: ${b_cyan}.todo${c_cyan} already exists${c_none}"
        fi
        exit 0
    # find in single file
    else
        echo ""
        echo "\n${b_cyan}$0${c_cyan}: ${c_yellow}$1${c_none}\n"
        grep -F -n "# TODO" $1 | sed 's/:[[:blank:]]*/: /' | sed "s/# TODO//" | perl -ne 'print "  $_"'
    fi
fi

echo ""
