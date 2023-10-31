#!/bin/sh

c_none="\033[0m"
c_cyan="\033[0;36m"
c_yellow="\033[0;33m"
b_cyan="\033[1;36m"

if [ $# -eq 0 ];
then
    # .todoconfig to add files to search in (this works better i think)
    if test -f .todoconfig; then
        echo "${b_cyan}$0${c_cyan}: ${b_cyan}.todoconfig${c_cyan} found${c_none}"
        echo "${b_cyan}$0${c_cyan}: search only in file -> todo <file>${c_none}\n"
        for file in $(cat .todoconfig)
        do
            echo "${c_yellow}$file${c_none}"
            grep -F -n "# TODO:" $file | sed 's/:[[:blank:]]*/: /' | sed "s/# TODO://" | perl -ne 'print "  $_"'
        done
    else
        echo "${b_cyan}$0${c_cyan}: ${b_cyan}.todoconfig${c_cyan} is missing${c_none}"
        echo "${b_cyan}$0${c_cyan}: create it with -> todo init${c_none}"
    fi
    # # .todoignore (this is too annoying with .git and all garbage)
    # IGNORE=false
    # if test -f .todoignore; then
    #     IGNORE=true
    #     echo "${b_cyan}$0${c_cyan}: ignore${c_none}"
    #     cat .todoignore | perl -ne 'print "  $_"'
    #     echo ""
    # else
    #     echo "${b_cyan}$0${c_cyan}: ${b_cyan}.todoignore${c_cyan} is missing${c_none}"
    # fi
    # # traverse all files
    # echo "${b_cyan}$0${c_cyan}: filter by file -> todo <file>${c_none}\n"
    # for file in $(find . -type f -print)
    # do
    #     IN="${file/.\//}"
    #     IN_ARR=(${IN//\// })
    #     if [ "${IGNORE}" = false ] || ! grep -Fq "${IN_ARR[0]}" .todoignore
    #     then
    #         if [[ $0 != *"${file/.\//}"* ]] && [ $file != "./.todoignore" ];
    #         then
    #             echo "${c_yellow}$file${c_none}"
    #             # grep -F -n "TODO" $file | sed "s/TODO://" | perl -ne 'print "  $_"'
    #             grep -F -n "# TODO:" $1 | sed 's/:[[:blank:]]*/: /' | sed "s/# TODO://" | perl -ne 'print "  $_"'
    #         fi
    #     fi
    # done
else
    # todo init -> to create .todoconfig
    if [ $1 = "init" ];
    then
        if [ ! -f .todoconfig ];
        then
            touch .todoconfig
            echo "${b_cyan}$0${c_cyan}: ${b_cyan}.todoconfig${c_cyan} created${c_none}"
        else
            echo "${b_cyan}$0${c_cyan}: ${b_cyan}.todoconfig${c_cyan} already exists${c_none}"
        fi
        exit 0
    # find in single file
    else
        echo "\n${b_cyan}$0${c_cyan}: ${c_yellow}$1${c_none}\n"
        grep -F -n "# TODO:" $1 | sed 's/:[[:blank:]]*/: /' | sed "s/# TODO://" | perl -ne 'print "  $_"'
    fi
fi

echo ""
