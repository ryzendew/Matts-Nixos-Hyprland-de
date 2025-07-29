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

  # Import polkit rules
  imports = [ ./polkit-rules.nix ];
} 