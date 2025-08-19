{ config, pkgs, unstablePkgs, aff, ... }:

{
  # Keyboard & console
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    xkb.options = "";
  };
  console.useXkbConfig = true;

  # Display Manager
  services.displayManager.gdm.enable = true;

  # Audio via PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Secret service for password storage
  services.gnome.gnome-keyring.enable = true;
  
  # Auto-unlock keyring on login
  security.pam.services.login.enableGnomeKeyring = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # NVIDIA
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  # Wayland portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gnome
    kdePackages.xdg-desktop-portal-kde
  ];

  # Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    fira-sans roboto nerd-fonts._0xproto nerd-fonts.droid-sans-mono
    jetbrains-mono noto-fonts noto-fonts-emoji noto-fonts-cjk-sans
    noto-fonts-cjk-serif material-symbols material-icons
    
    # Additional font support
    fontconfig
    freetype
    liberation_ttf
    dejavu_fonts
    ubuntu_font_family
  ];

  # Environment variables for Qt/QML
  environment.variables = {
    QML2_IMPORT_PATH = "/nix/store/b4p9px4l3rsah72pyh95s1j68ik84k9i-qt5compat-6.9.1/lib/qt-6/qml:/nix/store/g0dwy4lps5gbslyqc54986vp2zwcb3is-qtgraphicaleffects-5.15.17/lib/qt-5.15.2/qml";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_ENABLE_HIGHDPI_SCALING = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    
    # X11/AppImage compatibility for Wayland
    DISPLAY = ":0";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland,x11";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_WAYLAND_FORCE_DPI = "physical";
    
    # Additional X11/Electron compatibility
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    ELECTRON_ENABLE_LOGGING = "1";
    ELECTRON_ENABLE_STACK_DUMPING = "1";
    CHROME_EXTRA_ARGS = "--enable-features=Vulkan,VulkanFromANGLE --disable-gpu-sandbox --no-sandbox --disable-dev-shm-usage";
    
    # Override problematic Qt style variable
    QT_STYLE_OVERRIDE = "";
  };

  # Session variables for KDE style support
  environment.sessionVariables = {
    QT_QUICK_CONTROLS_STYLE = "org.kde.desktop";
    FONTCONFIG_PATH = "/etc/fonts";
    FREETYPE_PROPERTIES = "truetype:interpreter-version=40";
  };

  # Environment packages
  environment.systemPackages = with pkgs; [
    vesktop glxinfo mangohud lutris steam heroic ptyxis
    flatpak fuse3 nwg-displays winetricks jq wine-staging
    texlivePackages.microtype code-cursor fastfetch
    tela-circle-icon-theme git oh-my-posh lyra-cursors
    steam-run perl wget curl p7zip gnutar unzip
    appimage-run pavucontrol mpv

    # File manager
    nautilus

    # Disk utility
    gnome-disk-utility



    # GTK
    gtk3
    gtk4

    # Secret service
    gnome-keyring
    libsecret

    # Development tools
    github-desktop
    python313
    gedit
    vscode

    # Qt packages for Quickshell
    qt6.qt5compat
    qt5.qtgraphicaleffects
    qt5.qtquickcontrols2

    # KDE style support for Quickshell
    libsForQt5.qt5ct

    # Unstable channel
    unstablePkgs.hyprland
    unstablePkgs.hyprpaper
    unstablePkgs.hyprpicker
    unstablePkgs.hypridle
    unstablePkgs.hyprlock
    unstablePkgs.hyprgraphics
    unstablePkgs.aquamarine
    unstablePkgs.rustup
    unstablePkgs.rustc
    unstablePkgs.swww
  ] ++ [ aff.hyprswitch ];
} 
