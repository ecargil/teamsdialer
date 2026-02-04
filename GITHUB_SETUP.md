# GitHub Setup Instructions

## Initial Setup

1. **Build the installer first**
   ```powershell
   .\Build.ps1
   .\BuildInnoSetup.ps1
   ```

2. **Initialize Git repository**
   ```bash
   git init
   git add .
   git commit -m "Initial release v1.0.0 - Self-installing tel: protocol handler for Microsoft Teams"
   ```

3. **Create GitHub repository**
   - Go to https://github.com/new
   - Repository name: `TeamsDialer`
   - Description: `A lightweight Windows application that registers as a tel: protocol handler to make phone calls directly through Microsoft Teams`
   - Public repository
   - DO NOT initialize with README, .gitignore, or license (already included)

4. **Push to GitHub**
   ```bash
   git remote add origin https://github.com/ecargil/teamsdialer.git
   git branch -M main
   git push -u origin main
   ```

**Note**: The installer `TeamsDialerSetup.exe` is included in the repository so users can download and install directly without building from source.

## Creating a Release

1. **Update version and rebuild** (if needed)
   ```powershell
   .\Build.ps1
   .\BuildInnoSetup.ps1
   git add TeamsDialerSetup.exe
   git commit -m "Update installer for v1.0.1"
   git push
   ```

2. **Create a release on GitHub**
   - Go to https://github.com/ecargil/teamsdialer/releases/new
   - Tag version: `v1.0.0`
   - Release title: `TeamsDialer v1.0.0`
   - Description: Copy from CHANGELOG in README.md
   - Optionally attach additional files:
     - `TeamsDialer.exe` (portable version, if you want to provide it separately)

3. **Publish the release**

**Note**: Users can download `TeamsDialerSetup.exe` directly from the repository without waiting for a release.

## Future Updates

```bash
# Make changes to code
git add .
git commit -m "Description of changes"
git push

# For new releases, create a new tag
git tag v1.0.1
git push origin v1.0.1
```
