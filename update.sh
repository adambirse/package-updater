#!/bin/bash

get_outdated_packages() {
    # Get a list of outdated packages using yarn
    # format is actually json_lines and not json
    yarn outdated --json | tail -n -1 | jq -r '.data.body[][0]'
}

get_blacklist() {
    local filename=$1
    # Retrieve the blacklist from the package.json file
    jq -r '.["package-updater"].black_list[]' "$filename"
}

update_package() {
    local package=$1
    # Update the specified package to the latest version
    echo "Updating $package"
    yarn upgrade "$package" --latest
}

update_packages() {
    local blacklist=($1)
    local outdated=($2)

    for package in "${outdated[@]}"
    do
        # If the package is not in the blacklist
        if [[ ! " ${blacklist[@]} " =~ " ${package} " ]]; then
            update_package "$package"
        fi 
    done
}

main() {
    local package_json="package.json"

    # Get the blacklist from package.json
    local blacklist=$(get_blacklist "$package_json")
    echo "Blacklist: ${blacklist[@]}"

    # Get the outdated packages
    local outdated=$(get_outdated_packages)
    echo "Outdated packages: ${outdated[@]}"

    # Update the packages
    update_packages "$blacklist" "$outdated"
}

# Entry point
main
