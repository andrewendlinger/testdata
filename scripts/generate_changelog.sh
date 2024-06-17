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

# Generate changelog header
echo "---" > CHANGELOG.md
echo "## $latest_tag ($formatted_date)" > CHANGELOG.md

# Append commits to changelog
git log --pretty=format:"- [%h](https://github.com/andrewendlinger/testdata/commit/%H) %s" $latest_tag..HEAD >> CHANGELOG.md

# Add a new line at the end of the file
echo "" >> CHANGELOG.md

# Commit changelog
git add CHANGELOG.md
git commit -m "Updated changelog to $latest_tag"
git push origin HEAD:main
