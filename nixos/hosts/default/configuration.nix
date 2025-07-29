{ config, pkgs, unstablePkgs, quickshell, aff, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Hostname & networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale & timezone
  i18n.defaultLocale = "en_CA.UTF-8";
  time.timeZone = "America/Halifax";

  # User "matt"
  users.users.matt = {
    isNormalUser = true;
    description = "matt";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Automount
  fileSystems."/mnt/Gaming" = {
    device = "UUID=cec667b1-c789-48fe-9057-96a8562bbbc0";
    fsType = "xfs";
    options = [ "nofail" "x-systemd.device-timeout=5s" ];
  };

  # Flake & Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    allowed-users = [ "matt" ];
    auto-optimise-store = true;
  };

  # Kernel boot parameters
  boot.kernelParams = [
    "amdgpu.dcdebugmask=0x10"
  ];

  system.stateVersion = "25.11";
} 
