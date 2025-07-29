{ config, pkgs, ... }:

{
  # XDG settings
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
} 