#!/bin/bash

# Ensure the script exits on the first error encountered
set -e

# Check if CHANGELOG.md exists; create it if it doesn't
if [ ! -f CHANGELOG.md ]; then
    touch CHANGELOG.md
fi

# Fetch all tags and latest changes
git fetch --tags
git pull origin main

# Fetch latest tag and date
latest_tag=$(git describe --tags --abbrev=0)
latest_tag_date=$(git log -1 --format=%ai $latest_tag | cut -d ' ' -f 1)
formatted_date=$(date -d $latest_tag_date +"%dth of %B %Y")

# Create a temporary file for the new changelog entry
temp_file=$(mktemp)

# Generate changelog header in the temporary file
echo "---" > $temp_file
echo "" > $temp_file
echo "## $latest_tag ($formatted_date)" >> $temp_file

# Loop through all commits since the last push and append to the temporary file
echo "Changes since last push to main:" >> "$temp_file"
git log --pretty=format:"- [%h](https://github.com/andrewendlinger/testdata/commit/%H) %s" "$last_push_commit"..HEAD >> "$temp_file"

# Add a new line at the end of the temporary file
echo "" >> $temp_file

# Concatenate the temporary file and the existing CHANGELOG.md
cat $temp_file CHANGELOG.md > CHANGELOG.md.new

# Replace the old CHANGELOG.md with the new one
mv CHANGELOG.md.new CHANGELOG.md

# Remove the temporary file
rm $temp_file

# Commit changelog
git add CHANGELOG.md
git commit -m "Updated changelog to $latest_tag"
git push origin HEAD:main
