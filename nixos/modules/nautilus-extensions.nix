{ config, pkgs, aff, ... }:

{
  # Install nautilus-open-in-ptyxis extension
  system.activationScripts.nautilus-extensions = ''
    echo "Setting up Nautilus extensions..."
    
    # Create nautilus extensions directory
    mkdir -p /home/matt/.local/share/nautilus-python/extensions/nautilus-open-in-ptyxis
    
    # Copy the nautilus-open-in-ptyxis extension
    if [ -d "${aff.nautilus-open-in-ptyxis}" ]; then
      cp -r ${aff.nautilus-open-in-ptyxis}/* /home/matt/.local/share/nautilus-python/extensions/nautilus-open-in-ptyxis/
      chown -R matt:users /home/matt/.local/share/nautilus-python/extensions/nautilus-open-in-ptyxis/
      echo "Nautilus-open-in-ptyxis extension installed successfully!"
    else
      echo "Warning: nautilus-open-in-ptyxis source not found"
    fi
  '';

  # Add nautilus-python dependency
  environment.systemPackages = with pkgs; [
    nautilus-python
  ];
} 