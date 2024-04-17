#!/bin/bash

get_outdated_packages() {
    # Get a list of outdated packages
    # outdated=$(npm outdated --json | jq -r 'keys[]')
    # yarn gives error
    # jq: error (at <stdin>:1): Cannot index string with string "body"
    # but it seems to work ???
        yarn outdated --json | jq -r '.data.body[][0]'
}

get_blacklist() {
    local filename=$1
    jq -r '.["package-updater"].black_list[]' $filename
}

update_packages() {
    local blacklist=$1
    local outdated=$2

    for package in $outdated
    do
        # If the package is not in the blacklist
        if ! [[ " ${blacklist[@]} " =~ " ${package} " ]]
        then
            # Update the package
            echo updating $package
            yarn upgrade $package --latest
        fi 
    done
}

blacklist=$(get_blacklist "package.json")
echo blacklist $blacklist


outdated=$(get_outdated_packages)
echo outdated $outdated




update_packages "$blacklist" "$outdated"