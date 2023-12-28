#!/bin/bash

# Change working directory to the script's folder
cd "$(dirname "$0")"

# Get the current date and time
current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

# Check if there are any changes to commit
if git diff --quiet; then
  echo "No changes to commit."
else
  # Add all changes and commit
  git add .
  git commit -m "Auto-commit at ${current_datetime}"

  # Push changes to the remote repository
  git push origin main  # Change 'main' to your branch name if different
fi

