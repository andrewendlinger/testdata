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


# Create a temporary file for the new changelog entry
temp_file=$(mktemp)

# Generate changelog header in the temporary file
echo "---" > $temp_file
echo "" > $temp_file
echo "## $current_version (date)" >> $temp_file

# Loop through all commits since the last push and append to the temporary file
echo "Changes since last push to main:" >> "$temp_file"
git log --pretty=format:"- [%h](https://github.com/andrewendlinger/testdata/commit/%H) %s" "v$current_version..HEAD" >> "$temp_file"

# Add a new line at the end of the temporary file
echo "" >> $temp_file

# Concatenate the temporary file and the existing CHANGELOG.md
cat $temp_file CHANGELOG.md > CHANGELOG.md.new

# Replace the old CHANGELOG.md with the new one
mv CHANGELOG.md.new CHANGELOG.md

# Remove the temporary file
rm $temp_file


# Create a tag for this version
git tag "v$new_version"
git push origin "v$new_version"

# Commit version bump
git add version.txt
git commit -m "Bump version to $new_version"
git push origin HEAD:main