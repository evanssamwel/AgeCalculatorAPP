#!/bin/bash

echo "Pulling latest changes from remote..."
git pull origin main --allow-unrelated-histories

# Use null-separated list to handle spaces safely
files=$(git status --porcelain -z | awk -v RS='\0' '{print $2}')

if [ -z "$files" ]; then
  echo "No changed or untracked files to commit."
  exit 0
fi

# Convert null-separated to array
IFS=$'\n' read -d '' -r -a file_array <<< "$(git status --porcelain -z | awk -v RS='\0' '{print $2}')"

echo "Found ${#file_array[@]} files to commit and push."

for file in "${file_array[@]}"; do
  echo "Processing \"$file\" ..."
  git add "$file"
  git commit -m "Add/update $file"
  git push origin main
done

echo "All files committed and pushed!"
