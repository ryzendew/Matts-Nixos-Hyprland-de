{ config, pkgs, ... }:

{
  # Global environment settings
  environment.variables = {
    # Add any global environment variables here
  };

  # System-wide environment packages
  environment.systemPackages = with pkgs; [
    # Add any system-wide packages here
  ];
} 