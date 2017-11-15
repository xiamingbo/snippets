#!/bin/bash

[ $# != 1 ] &&  echo "this script need one parameterUsage: update_git_dir /project/" && exit 1


function update_git_dir()
{
    echo "update dir: $1"
    cd $1
    [[ -d .git ]] && echo "$sub_dir is a git dir, update" && git pull && return
    for sub_dir in `ls`
    do
        if [[ -d .git ]]; then
            echo "$sub_dir is a git dir, update"
            git pull 
            continue
        elif [[ -d $sub_dir ]]; then
            echo "$sub_dir is not a git dir, update its sub dir."
            update_git_dir $sub_dir 
        fi
    done
    cd ..
}

update_git_dir $1
