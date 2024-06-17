#!/bin/bash

# Ensure the script exits on the first error encountered
set -e

# Fetch all tags and latest changes
git fetch --tags
git pull origin main

# Check if version.txt exists; create it if it doesn't
if [ ! -f version.txt ]; then
    echo "0.0.0" > version.txt
fi

# Now proceed with the rest of the version bumping logic
current_version=$(<version.txt)
IFS='.' read -r -a version_parts <<< "$current_version"
major=${version_parts[0]}
minor=${version_parts[1]}
patch=${version_parts[2]}
new_version="$major.$minor.$((patch + 1))"
echo "$new_version" > version.txt
echo "Bumped version to $new_version"

# Create a tag for this version
git tag "v$new_version"
git push origin "v$new_version"

# Commit version bump
git add version.txt
git commit -m "Bump version to $new_version"
git push origin HEAD:main