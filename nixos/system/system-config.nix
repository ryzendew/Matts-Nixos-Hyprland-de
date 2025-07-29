{ config, pkgs, ... }:

{
  imports = [
    ./environment.nix
    ./xdg.nix
  ];
} 