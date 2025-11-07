# Branch Setup Instructions

This document outlines the steps needed to create the required branches and set the default branch for this repository.

## Required Changes

1. **Create `src-data` branch**
2. **Create `production` branch**
3. **Set `src-data` as the default/main branch**

## Manual Steps Required

Since these changes require repository administration privileges, they must be done through the GitHub web interface or GitHub CLI with appropriate permissions.

### Option 1: Using GitHub Web Interface

1. Navigate to the repository: https://github.com/cmip-ipo-internal/WCRP-citations
2. Click on the branch dropdown (currently showing the default branch)
3. Type `src-data` in the "Find or create a branch" field
4. Click "Create branch: src-data from [current-branch]"
5. Repeat steps 3-4 for `production` branch
6. Go to Settings → Branches
7. Under "Default branch", click the switch icon
8. Select `src-data` from the dropdown
9. Click "Update" and confirm the change

### Option 2: Using GitHub CLI (gh)

With appropriate repository permissions:

```bash
# Create src-data branch
gh api repos/cmip-ipo-internal/WCRP-citations/git/refs \
  -f ref='refs/heads/src-data' \
  -f sha='<commit-sha>'

# Create production branch
gh api repos/cmip-ipo-internal/WCRP-citations/git/refs \
  -f ref='refs/heads/production' \
  -f sha='<commit-sha>'

# Set src-data as default branch
gh api repos/cmip-ipo-internal/WCRP-citations \
  -X PATCH \
  -f default_branch='src-data'
```

### Option 3: Using Git Commands (with push access)

```bash
# Create and push src-data branch
git checkout -b src-data
git push -u origin src-data

# Create and push production branch
git checkout -b production
git push -u origin production

# Note: Setting the default branch still requires GitHub web UI or API
```

## Verification

After completing these steps:

1. Verify both branches exist:
   ```bash
   git fetch --all
   git branch -a
   ```

2. Verify the default branch is `src-data`:
   - Check on GitHub web interface
   - Or use: `gh repo view cmip-ipo-internal/WCRP-citations --json defaultBranchRef`

## Notes

- The default branch is what users see when they visit the repository
- The default branch is used as the base for new pull requests
- Changing the default branch does not affect existing clones or branches
