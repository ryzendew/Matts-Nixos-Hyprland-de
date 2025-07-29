{ config, pkgs, ... }:

{
  # Polkit rules for storage access and common operations
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.udisks2.filesystem-mount" ||
          action.id == "org.freedesktop.udisks2.filesystem-unmount" ||
          action.id == "org.freedesktop.udisks2.encrypted-unlock" ||
          action.id == "org.freedesktop.udisks2.encrypted-lock" ||
          action.id == "org.freedesktop.udisks2.loop-setup" ||
          action.id == "org.freedesktop.udisks2.loop-delete" ||
          action.id == "org.freedesktop.udisks2.drive-eject" ||
          action.id == "org.freedesktop.udisks2.drive-detach" ||
          action.id == "org.freedesktop.udisks2.power-off-drive" ||
          action.id == "org.freedesktop.udisks2.power-off-drive-system" ||
          action.id == "org.freedesktop.udisks2.modify-device" ||
          action.id == "org.freedesktop.udisks2.modify-device-system" ||
          action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
          action.id == "org.freedesktop.udisks2.filesystem-unmount-system" ||
          action.id == "org.freedesktop.udisks2.filesystem-mount-other-seat" ||
          action.id == "org.freedesktop.udisks2.filesystem-unmount-other-seat" ||
          action.id == "org.freedesktop.udisks2.encrypted-unlock-other-seat" ||
          action.id == "org.freedesktop.udisks2.encrypted-lock-other-seat" ||
          action.id == "org.freedesktop.udisks2.eject-media" ||
          action.id == "org.freedesktop.udisks2.eject-media-system" ||
          action.id == "org.freedesktop.udisks2.eject-media-other-seat" ||
          action.id == "org.freedesktop.udisks2.close-media" ||
          action.id == "org.freedesktop.udisks2.close-media-system" ||
          action.id == "org.freedesktop.udisks2.close-media-other-seat" ||
          action.id == "org.freedesktop.udisks2.open-device" ||
          action.id == "org.freedesktop.udisks2.open-device-system" ||
          action.id == "org.freedesktop.udisks2.open-device-other-seat") {
        return polkit.Result.YES;
      }
    });
  '';
} 