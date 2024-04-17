# Get the blacklist from package.json
blacklist=$(jq -r '.["package-updater"].black_list[]' package.json)
echo blacklist $blacklist
# Get a list of outdated packages
# outdated=$(npm outdated --json | jq -r 'keys[]')
outdated=$(yarn outdated --json | jq -r '.data.body[] .[0]')

echo outdated $outdated
# # Loop through the outdated packages
for package in $outdated
do
    # If the package is not in the blacklist
    if ! [[ " ${blacklist[@]} " =~ " ${package} " ]]
    then
        # Update the package
        echo updating $package
        # npm update $package
    else 
        echo $package is in the blacklist
     fi
done