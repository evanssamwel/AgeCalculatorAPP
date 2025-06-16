#!/bin/bash

# Pull latest changes, allow unrelated histories just in case
echo "Pulling latest changes from remote..."
git pull origin main --allow-unrelated-histories

# Get list of changed or untracked files
files=$(git status --porcelain | awk '{print $2}')

if [ -z "$files" ]; then
  echo "No changed or untracked files to commit."
  exit 0
fi

echo "Found $(echo "$files" | wc -w) files to commit and push."

# Loop through each file, add, commit with default message, and push
for file in $files; do
  echo "Processing $file ..."
  git add "$file"
  git commit -m "Add/update $file"
  git push origin main
done

echo "All files committed and pushed!"
