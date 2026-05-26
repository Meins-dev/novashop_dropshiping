#!/usr/bin/env bash
set -euo pipefail

# Script to create a GitHub repo named 'projeto_site' and push the current
# branch. Requires the GitHub CLI (`gh`) to be installed and authenticated.

REPO_NAME=projeto_site
REMOTE=projeto_site

if ! command -v gh >/dev/null 2>&1; then
  echo "gh (GitHub CLI) is not installed. Install from https://cli.github.com/" >&2
  exit 1
fi

echo "Creating GitHub repo $REPO_NAME and pushing current branch..."

if gh auth status >/dev/null 2>&1; then
  gh repo create "$REPO_NAME" --public --source=. --remote="$REMOTE" --push || {
    echo "gh repo create failed. Check existing remotes or permissions." >&2
    exit 1
  }
else
  echo "gh is not authenticated. Run 'gh auth login' first or set GH_TOKEN." >&2
  exit 1
fi

echo "Done. Remote '$REMOTE' configured. Use: git remote -v" 
