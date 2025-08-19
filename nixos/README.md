# NixOS Gaming & Content Creation Setup

A comprehensive NixOS 25.11 configuration optimized for gaming and content creation, featuring Hyprland desktop environment with Quickshell integration.

## 🎮 Gaming Setup

### Game Launchers & Platforms
- **Steam** - Primary game launcher with remote play support
- **Heroic Games Launcher** - Epic Games Store and GOG integration
- **Lutris** - Universal game launcher with Wine integration
- **ProtonPlus** - Enhanced Proton compatibility layer

### Gaming Tools
- **MangoHud** - FPS overlay and performance monitoring
- **Gamemode** - CPU governor optimization for gaming
- **Wine Staging** - Latest Wine version for Windows games
- **Steam-run** - Steam runtime for native Linux games

### Graphics & Performance
- **NVIDIA Drivers** - Latest stable drivers with open source components
- **Mesa-git** - Latest Mesa graphics drivers via Chaotic-AUR
- **Hyprgraphics** - Enhanced graphics support for Hyprland
- **Vulkan** - Full Vulkan support for modern games
- **CachyOS Kernel** - Optimized kernel for gaming and performance

## 🎨 Content Creation

### Video Editing
- **DaVinci Resolve Studio** - Professional video editing suite
- **OBS Studio** - Streaming and recording with NVENC support
- **MPV** - Lightweight video player

### Audio Production
- **EasyEffects** - Audio effects and equalizer
- **Helvum** - Audio patchbay for routing
- **QPWGraph** - Audio graph visualization
- **PulseAudio** - Audio system with PipeWire compatibility

### Image & Design
- **Affinity Photo** - Professional photo editing
- **Affinity Designer** - Vector graphics and design
- **SWWW** - Dynamic wallpaper daemon
- **Hyprpicker** - Color picker for Hyprland

## 🖥️ Desktop Environment

### Hyprland + Quickshell
- **Hyprland** - Modern Wayland compositor
- **Quickshell** - Qt-based shell with overview and widgets
- **Hyprswitch** - Window switcher and application launcher

### System Components
- **SDDM** - Display manager with Wayland support
- **Waybar** - Status bar for Hyprland
- **Wlogout** - Logout screen
- **Fuzzel** - Application launcher
- **Anyrun** - Alternative application launcher

### Configuration Integration
- **Reborn-Quickshell** - Complete configuration from [ryzendew/Reborn-Quickshell](https://github.com/ryzendew/Reborn-Quickshell)
- **Auto-copied configurations** for Hyprland, Quickshell, Waybar, SWWW, Wlogout, Fuzzel, Anyrun, GTK, and Qt themes

## 🛠️ Development & Utilities

### Development Tools
- **GitHub Desktop** - Git GUI client
- **Rustup & Rustc** - Rust programming language
- **Fastfetch** - System information display

### System Utilities
- **Nautilus** - File manager
- **GNOME Disk Utility** - Disk management
- **Ptyxis** - Terminal emulator
- **Flatpak** - Application sandboxing
- **AppImage-run** - AppImage support

### Network & System
- **NetworkManager** - Network configuration
- **Polkit** - Privilege management
- **Hyprpolkitagent** - Polkit integration for Hyprland
- **Cliphist** - Clipboard history
- **Grim & Slurp** - Screenshot tools

## 📦 Package Sources

### Flake Inputs
- **nixpkgs/nixos-unstable** - Latest NixOS packages
- **home-manager** - User configuration management
- **chaotic-cx/nyx** - Chaotic-AUR overlay for mesa-git and other packages
- **affinity-nix** - Affinity Creative Suite packages
- **quickshell** - Quickshell shell
- **hyprpolkitagent** - Hyprland polkit agent
- **hyprswitch** - Window switcher
- **Reborn-Quickshell** - Complete desktop configuration

### Overlays
- **Chaotic-AUR** - Provides mesa-git, davinci-resolve-studio, and other packages
- **Custom packages** - Quickshell and other custom builds

## 🎯 Key Features

### Out-of-the-Box Gaming
- **Zero-config gaming** - Steam, Heroic, and Lutris ready
- **Proton compatibility** - Windows games work immediately
- **Performance optimization** - MangoHud and Gamemode included
- **Hardware acceleration** - NVIDIA + Mesa-git for maximum compatibility

### Content Creation Ready
- **Professional tools** - DaVinci Resolve Studio, Affinity Suite
- **Audio production** - Complete audio pipeline with PipeWire
- **Streaming setup** - OBS with NVENC encoding
- **Color management** - Hyprpicker and SWWW for visual work

### Modern Desktop
- **Wayland-native** - Hyprland with full Wayland support
- **Qt integration** - Quickshell with KDE styling
- **GTK compatibility** - Full GTK3/GTK4 support
- **XDG portals** - GNOME, KDE, and Hyprland portal support

## 🚀 Quick Start

1. **Clone the repository**
2. **Update flake inputs**: `nix flake update`
3. **Build and switch**: `sudo nixos-rebuild switch --flake .#nixos`
4. **Log in** and enjoy your gaming & content creation setup!

## 📁 Project Structure

```
nixos/
├── 📦 flake.nix                    # Main flake configuration
├── 📋 flake.lock                   # Locked dependencies
├── 📖 README.md                    # This documentation
│
├── 🏠 hosts/
│   └── default/
│       ├── 🖥️  configuration.nix      # Main system configuration
│       ├── 🔧 hardware-configuration.nix  # Hardware-specific settings
│       └── 👤 home.nix              # User-specific configuration
│
├── 🧩 modules/
│   ├── 🖥️  desktop/
│   │   └── desktop-environment.nix  # Desktop environment & graphics
│   ├── 📝 editors/
│   │   └── editor-config.nix        # Editor configurations
│   ├── 🛠️  programs/
│   │   ├── system-programs.nix      # System programs & services
│   │   └── polkit-rules.nix         # Polkit security rules
│   └── 🎨 hyprlandde-quickshell.nix # Reborn-Quickshell integration
│
├── ⚙️  system/
│   ├── system-config.nix           # System-level configuration
│   ├── environment.nix             # Environment variables
│   └── xdg.nix                     # XDG portal settings
│
└── 🎨 assets/
    ├── 🖼️  wallpapers/              # Wallpaper collection
    └── 🎯 icons/                    # Custom icons
```

## 🔧 Customization

The configuration is modular and easily customizable:
- `modules/desktop/desktop-environment.nix` - Desktop environment settings
- `modules/programs/system-programs.nix` - System programs and services
- `modules/hyprlandde-quickshell.nix` - Reborn-Quickshell integration
- `hosts/default/home.nix` - User-specific configuration

## 📝 Notes

- **NixOS 25.11** with latest unstable packages
- **Mesa-git** from Chaotic-AUR for latest graphics features
- **NVIDIA drivers** with open source components enabled
- **Hyprland** as the primary desktop environment
- **Quickshell** for enhanced desktop experience

---

*Built with ❤️ for gaming and content creation on NixOS* 