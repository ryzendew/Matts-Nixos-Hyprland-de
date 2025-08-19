{ config, pkgs, aff, ... }:

let
  # Source directory from the flake input
  sourceDir = aff.hyprlandde-quickshell + "/.config";
  
  # Configuration - change this to match your username
  username = "matt";
  userHome = "/home/${username}";
  targetDir = "${userHome}/.config";
in
{
  # Create the configuration files from the repository
  system.activationScripts.hyprlandde-quickshell = ''
    echo "Setting up Reborn-Quickshell configuration..."
    
    # Create target directories if they don't exist
    mkdir -p ${targetDir}/hypr
    mkdir -p ${targetDir}/quickshell
    mkdir -p ${targetDir}/ags
    mkdir -p ${targetDir}/waybar
    mkdir -p ${targetDir}/swww
    mkdir -p ${targetDir}/wlogout
    mkdir -p ${targetDir}/fuzzel
    mkdir -p ${targetDir}/anyrun
    mkdir -p ${targetDir}/gtk-3.0
    mkdir -p ${targetDir}/gtk-4.0
    mkdir -p ${targetDir}/qt5ct
    mkdir -p ${targetDir}/qt6ct
    
    # Copy configuration files
    if [ -d "${sourceDir}" ]; then
      # Copy hyprland config
      if [ -d "${sourceDir}/hypr" ]; then
        cp -r ${sourceDir}/hypr/* ${targetDir}/hypr/ 2>/dev/null || true
      fi
      
      # Copy quickshell config
      if [ -d "${sourceDir}/quickshell" ]; then
        cp -r ${sourceDir}/quickshell/* ${targetDir}/quickshell/ 2>/dev/null || true
      fi
      
      # Copy ags config
      if [ -d "${sourceDir}/ags" ]; then
        cp -r ${sourceDir}/ags/* ${targetDir}/ags/ 2>/dev/null || true
      fi
      
      # Copy waybar config
      if [ -d "${sourceDir}/waybar" ]; then
        cp -r ${sourceDir}/waybar/* ${targetDir}/waybar/ 2>/dev/null || true
      fi
      
      # Copy swww config
      if [ -d "${sourceDir}/swww" ]; then
        cp -r ${sourceDir}/swww/* ${targetDir}/swww/ 2>/dev/null || true
      fi
      
      # Copy wlogout config
      if [ -d "${sourceDir}/wlogout" ]; then
        cp -r ${sourceDir}/wlogout/* ${targetDir}/wlogout/ 2>/dev/null || true
      fi
      
      # Copy fuzzel config
      if [ -d "${sourceDir}/fuzzel" ]; then
        cp -r ${sourceDir}/fuzzel/* ${targetDir}/fuzzel/ 2>/dev/null || true
      fi
      
      # Copy anyrun config
      if [ -d "${sourceDir}/anyrun" ]; then
        cp -r ${sourceDir}/anyrun/* ${targetDir}/anyrun/ 2>/dev/null || true
      fi
      
      # Copy gtk configs
      if [ -d "${sourceDir}/gtk-3.0" ]; then
        cp -r ${sourceDir}/gtk-3.0/* ${targetDir}/gtk-3.0/ 2>/dev/null || true
      fi
      if [ -d "${sourceDir}/gtk-4.0" ]; then
        cp -r ${sourceDir}/gtk-4.0/* ${targetDir}/gtk-4.0/ 2>/dev/null || true
      fi
      
      # Copy qt configs
      if [ -d "${sourceDir}/qt5ct" ]; then
        cp -r ${sourceDir}/qt5ct/* ${targetDir}/qt5ct/ 2>/dev/null || true
      fi
      if [ -d "${sourceDir}/qt6ct" ]; then
        cp -r ${sourceDir}/qt6ct/* ${targetDir}/qt6ct/ 2>/dev/null || true
      fi
      
      # Set proper ownership
      chown -R ${username}:users ${targetDir}/hypr
      chown -R ${username}:users ${targetDir}/quickshell
      
      echo "Reborn-Quickshell configuration copied successfully!"
    else
      echo "Warning: Reborn-Quickshell source directory not found"
    fi
  '';

  # Add any additional packages that might be needed for the configuration
  environment.systemPackages = with pkgs; [
    # Core components
    ags
    waybar
    swww
    wlogout
    fuzzel
    anyrun
    
    # Additional utilities that might be referenced in the configs
    grim
    slurp
    wl-clipboard
    cliphist
    hyprpicker
    hypridle
    hyprlock
    hyprpaper
  ];
} 