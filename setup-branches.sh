#!/bin/bash

# Script to create required branches for citation-mapper repository
# This script must be run by someone with write access to the repository

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

echo "Setting up branches for citation-mapper repository..."

# Get the current commit to base new branches on
BASE_COMMIT=$(git rev-parse HEAD)
echo "Base commit: $BASE_COMMIT"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Create src-data branch if it doesn't exist
if git show-ref --verify --quiet refs/heads/src-data; then
    echo "Branch 'src-data' already exists locally"
else
    echo "Creating src-data branch..."
    git branch src-data "$BASE_COMMIT"
fi

# Create production branch if it doesn't exist
if git show-ref --verify --quiet refs/heads/production; then
    echo "Branch 'production' already exists locally"
else
    echo "Creating production branch..."
    git branch production "$BASE_COMMIT"
fi

# Check if remote branches exist
echo ""
echo "Checking remote branches..."
git fetch origin

if git ls-remote --heads origin src-data | grep -q src-data; then
    echo "Remote branch 'origin/src-data' already exists"
else
    echo "Pushing src-data branch to origin..."
    git push origin src-data
fi

if git ls-remote --heads origin production | grep -q production; then
    echo "Remote branch 'origin/production' already exists"
else
    echo "Pushing production branch to origin..."
    git push origin production
fi

echo ""
echo "✓ Branches created successfully!"
echo ""
echo "Next step: Set src-data as the default branch"
echo "This requires repository admin access and must be done via:"
echo ""
echo "1. GitHub Web Interface:"
echo "   - Go to: https://github.com/cmip-ipo-internal/WCRP-citations/settings/branches"
echo "   - Under 'Default branch', click the switch icon"
echo "   - Select 'src-data'"
echo "   - Click 'Update' and confirm"
echo ""
echo "2. GitHub CLI (gh):"
echo "   gh api repos/cmip-ipo-internal/WCRP-citations -X PATCH -f default_branch='src-data'"
echo ""

# List all branches
echo "Current branches:"
git branch -a | grep -E '(src-data|production)'
