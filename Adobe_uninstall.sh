#!/bin/bash

# Check if there are enough arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: script.sh <app_name> <code>"
    exit 1
fi

# Check the architecture and adjust the platform accordingly
if [[ $(uname -m) == 'arm64' ]]; then
    chip="macOS"
else
    chip="osx10-64"
fi

# Name of the Adobe product and sapCode
app_name=$4
code=$5

# Find command to list all directories that match "Adobe <app_name>" pattern
app_paths=$(find /Applications -type d -maxdepth 2 -name "Adobe ${app_name}*.app" 2>/dev/null)

# Check if "find" found something
if [ -z "$app_paths" ]; then
    echo "Kein passender Ordner für '${app_name}' gefunden."
    exit 0
fi

# Loop for all found Adobe installations
while IFS= read -r app_path; do
    # Get the version of the application and shorten it
    version=$(mdls -name kMDItemVersion "$app_path" | awk -F '"' '{print $2}')
    major_version=$(echo "$version" | grep -o '^[0-9]\+')

    # Uninstall Adobe software
    "/Library/Application Support/Adobe/Adobe Desktop Common/HDBox/Setup" --uninstall=1 --sapCode=${code} --baseVersion=${major_version}.0 --platform=${chip} --deleteUserPreferences=false
    echo "Adobe ${app_name} with version ${version} found in folder '${app_path}' was deleted."
done <<< "$app_paths"
