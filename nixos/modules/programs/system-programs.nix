{ config, pkgs, unstablePkgs, aff, ... }:

{
  # Flatpak & printing
  services.flatpak.enable = true;
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Power management
  services.power-profiles-daemon.enable = true;

  # OBS with NVENC
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override { cudaSupport = true; };
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Additional environment packages for programs
  environment.systemPackages = with pkgs; [
    # Affinity + PolkitAgent
    aff.photo
    aff.designer
    aff.hyprpolkit
    
    # Audio and system utilities
    cava
    cliphist
    ddcutil
    pulseaudio
    
    # Wayland utilities
    slurp
    grim
    wl-clipboard
    
    # System utilities
    polkit_gnome
    bluez
    blueman
    bluez-tools
    pavucontrol
    
    # Audio utilities
    helvum
    qpwgraph
    easyeffects
    
    # Theme utilities
    nwg-look
    
    # DaVinci Resolve Paid
    (pkgs.callPackage /etc/nixos/davinci-resolve-paid.nix {})
  ];

  # Polkit configuration
  security.polkit.enable = true;
  
  # Start hyprpolkitagent automatically
  systemd.user.services.hyprpolkitagent = {
    description = "Hyprland Polkit Agent";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${aff.hyprpolkit}/bin/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  # DaVinci Resolve Paid auto-download
  system.activationScripts.davinci-resolve = ''
    echo "Setting up DaVinci Resolve Paid..."
    
    # Download the DaVinci Resolve Paid Nix file if it doesn't exist
    if [ ! -f /etc/nixos/davinci-resolve-paid.nix ]; then
      echo "Downloading DaVinci Resolve Paid Nix file..."
      curl -s -o /etc/nixos/davinci-resolve-paid.nix "https://acuifex.ru/blog/cracking-davinci-resolve-studio-license/davinci-resolve-paid.nix"
      chmod 644 /etc/nixos/davinci-resolve-paid.nix
      echo "DaVinci Resolve Paid Nix file downloaded successfully!"
    else
      echo "DaVinci Resolve Paid Nix file already exists."
    fi
  '';

  # Import polkit rules
  imports = [ ./polkit-rules.nix ];
} 