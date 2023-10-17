#!/bin/sh

c_none="\033[0m"
c_cyan="\033[0;36m"
c_yellow="\033[0;33m"
b_cyan="\033[1;36m"

if [ $# -eq 0 ];
then
    # .todoignore
    IGNORE=false
    if test -f .todoignore; then
        IGNORE=true
        echo "${b_cyan}$0${c_cyan}: ignore${c_none}"
        cat .todoignore | perl -ne 'print "  $_"'
        echo ""
    else
        echo "${b_cyan}$0${c_cyan}: ${b_cyan}.todoignore${c_cyan} is missing${c_none}"
    fi
    # traverse all files
    echo "${b_cyan}$0${c_cyan}: filter by file -> todo <file>${c_none}\n"
    for file in $(find . -type f -print)
    do
        IN="${file/.\//}"
        IN_ARR=(${IN//\// })
        if [ "${IGNORE}" = false ] || ! grep -Fq "${IN_ARR[0]}" .todoignore
        then
            if [[ $0 != *"${file/.\//}"* ]] && [ $file != "./.todoignore" ];
            then
                echo "${c_yellow}$file${c_none}"
                # grep -F -n "TODO" $file | sed "s/TODO://" | perl -ne 'print "  $_"'
                grep -F -n "TODO" $file | perl -ne 'print "  $_"'
            fi
        fi
    done
else
    echo "\n${b_cyan}$0${c_cyan}: ${c_yellow}$1${c_none}\n"
    grep -F -n "# TODO:" $1 | sed "s/# TODO://" | perl -ne 'print "  $_"'
fi

echo ""
