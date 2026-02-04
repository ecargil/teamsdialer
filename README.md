# TeamsDialer

A lightweight Windows application that registers as a `tel:` protocol handler to make phone calls directly through Microsoft Teams.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey)
![License](https://img.shields.io/badge/license-MIT-green)

## 🚀 Features

- **Self-Installing**: Automatically registers as `tel:` protocol handler on first run
- **No Admin Required**: Installs for current user without administrator privileges
- **Automatic Dialing**: Click any `tel:` link to instantly call via Microsoft Teams
- **Country Code Support**: Configurable default country prefix for local numbers
- **International Format**: Handles `+` and `00` prefixed numbers correctly
- **Simple Configuration**: Clean settings dialog to customize preferences
- **Lightweight**: Minimal resource usage, runs only when needed

## 📋 Requirements

- Windows 7 or later
- Microsoft Teams installed and logged in
- .NET Framework 2.0 or later (usually pre-installed on Windows)
  - If not installed, download from [Microsoft .NET Framework](https://dotnet.microsoft.com/download/dotnet-framework)

## 🔧 Installation

### Quick Install (Recommended)

1. Download `TeamsDialerSetup.exe` from this repository or the [Releases](https://github.com/ecargil/teamsdialer/releases) page
2. Run the installer as Administrator
3. Follow the installation wizard
4. Launch TeamsDialer from the Start Menu or let it launch automatically
5. Configure your default country prefix (e.g., `+34`, `+1`, `+44`)
6. Done! Click any `tel:` link to test

### Alternative: Portable Version

If you prefer not to use the installer:

1. Download `TeamsDialer.exe` from the [Releases](https://github.com/ecargil/teamsdialer/releases) page
2. Run `TeamsDialer.exe`
3. The application will automatically register itself as the `tel:` protocol handler
4. Configure your default country prefix
5. Click **Save**
6. Done!

**Note**: When you first click a `tel:` link, Windows may ask you to choose an application. Select TeamsDialer and check "Always use this app".

## 📖 Usage

### Making Calls

Once installed, simply click any `tel:` link in your browser or applications:

- `tel:627379032` → Calls +34627379032 (with default prefix +34)
- `tel:+1234567890` → Calls +1234567890 (international format)
- `tel:00441234567890` → Calls +441234567890 (converts 00 to +)

### Changing Settings

Run `TeamsDialer.exe` again to open the settings dialog and change your default country prefix.

## 🗑️ Uninstallation

### If installed with the installer:
- Go to Windows Settings → Apps → Apps & features
- Find "TeamsDialer" and click Uninstall

### If using portable version:
1. Run `Uninstall.bat` to remove all registry entries
2. Delete `TeamsDialer.exe`
3. Done!

## 🏗️ Project Structure

```
TeamsDialer/
├── Program.cs                  # Main application code
├── AssemblyInfo.cs            # Version and metadata
├── Build.ps1                  # Build script
├── BuildInnoSetup.ps1         # Build installer with Inno Setup
├── TeamsDialer.iss            # Inno Setup installer script
├── TeamsDialerSetup.exe       # Ready-to-use installer
├── Uninstall.bat              # Uninstaller for portable version
├── phone.ico                  # Application icon
├── README.md                  # This file
├── LICENSE                    # MIT License
├── CONTRIBUTING.md            # Contribution guidelines
├── GITHUB_SETUP.md            # GitHub setup instructions
└── .gitignore                 # Git ignore rules
```

## 🔨 Building from Source

### Prerequisites

- C# Compiler (csc.exe) - included with .NET Framework
- PowerShell 5.0 or later (for build script)

### Build Steps

```powershell
# Clone the repository
git clone https://github.com/ecargil/teamsdialer.git
cd TeamsDialer

# Build the application
.\Build.ps1

# Build the installer (requires Inno Setup)
.\BuildInnoSetup.ps1
```

Or compile manually:

```cmd
csc.exe /target:winexe /win32icon:phone.ico /r:System.Windows.Forms.dll /r:System.Drawing.dll /out:TeamsDialer.exe Program.cs AssemblyInfo.cs
```

**Note**: The installer `TeamsDialerSetup.exe` is included in the repository for convenience. You can use it directly without building.

## ⚙️ How It Works

1. **First Run**: When executed without arguments, TeamsDialer registers itself in the Windows Registry as a handler for `tel:` URLs
2. **URL Parsing**: When a `tel:` link is clicked, Windows launches TeamsDialer with the URL as an argument
3. **Number Processing**: 
   - Removes `tel:` prefix and formatting characters (spaces, dashes, parentheses)
   - Applies configured country code if the number has no international prefix
   - Converts `00` prefix to `+` format
4. **Teams Integration**: Constructs a properly URL-encoded Teams calling URL
5. **Teams Handling**: Microsoft Teams opens and initiates the call

## 🛠️ Technical Details

- **Language**: C# (.NET Framework 2.0)
- **UI Framework**: Windows Forms
- **Compiler**: Microsoft Visual C# 2005 compatible
- **Installation**: User-level (HKEY_CURRENT_USER), no admin rights required
- **Registry Keys**:
  - `HKCU\Software\Classes\tel` - Protocol handler registration
  - `HKCU\Software\TeamsDialer` - User settings and capabilities

## 🐛 Troubleshooting

### TeamsDialer doesn't appear as an option for tel: links

1. Run `TeamsDialer.exe` again to re-register
2. Click a `tel:` link and select TeamsDialer from the list
3. Check "Always use this app"

### Application doesn't start

- Ensure .NET Framework 2.0 or later is installed
- Download from [Microsoft .NET Framework](https://dotnet.microsoft.com/download/dotnet-framework) if needed

### Teams doesn't open when clicking tel: links

- Ensure Microsoft Teams is installed and you're logged in
- Verify the number format is correct (should start with `+`)
- Test manually: `TeamsDialer.exe tel:+1234567890`

### Settings don't save

- Ensure you have write permissions to the Windows Registry (HKEY_CURRENT_USER)
- Try running TeamsDialer again

## 📝 License

MIT License - See [LICENSE](LICENSE) file for details

## 👤 Author

**ecargil**
- GitHub: [@ecargil](https://github.com/ecargil)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## ⭐ Show your support

Give a ⭐️ if this project helped you!

## 📜 Changelog

### Version 1.0.0 (2024)
- Initial release
- Self-installing protocol handler
- Configurable country prefix
- Settings UI with GitHub link
- Automatic number formatting
- No administrator privileges required
