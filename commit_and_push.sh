#!/bin/bash

# Change working directory to the script's folder
cd "$(dirname "$0")"

# Check if there are any changes to commit
if [[ -n $(git status --porcelain) ]]; then
  # Add all changes and commit
  git add .
  git commit -m "Auto-commit"

  # Push changes to the remote repository
  git push origin main  # Change 'main' to your branch name if different
else
  echo "No changes to commit."
fi

