{ config, pkgs, lib, ... }:

let
  qt6 = pkgs.qt6;
  qt5 = pkgs.libsForQt5;
in
{
  home.username = "matt";
  home.homeDirectory = "/home/matt";

  home.packages = with pkgs; [
    qt5.qtgraphicaleffects
    qt5.qtquickcontrols2
    qt5.qtstyleplugin-kvantum
    qt6.qt5compat
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwayland
    qt6.qtmultimedia
    qt6.qtsvg
    qt6.qtshadertools
    qt6.qtbase.dev  # This includes Qt Widgets headers
    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qt5compat
  ];

  home.sessionVariables = {
    QT_PLUGIN_PATH = lib.concatStringsSep ":" [
      "${qt6.qtbase}/${qt6.qtbase.qtPluginPrefix}"
      "/run/current-system/sw/lib/qt-6/plugins"
      "/run/current-system/sw/lib/qt-5.15.17/plugins"
    ];
    QML2_IMPORT_PATH = lib.concatStringsSep ":" [
      "/run/current-system/sw/lib/qt-6/qml"
      "/run/current-system/sw/lib/qt-5.15.17/qml"
    ];
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QUICK_CONTROLS_STYLE = "org.kde.desktop";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_ENABLE_HIGHDPI_SCALING = "1";
    # Ensure Qt Widgets is available
    QT_WIDGETS_LIB = "${qt6.qtbase}/lib";
    LD_LIBRARY_PATH = lib.concatStringsSep ":" [
      "${qt6.qtbase}/lib"
      "/run/current-system/sw/lib"
    ];
    
    # Override problematic Qt style variable
    QT_STYLE_OVERRIDE = lib.mkForce "";
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum";
      package = pkgs.qt6Packages.qtstyleplugin-kvantum;
    };
  };

  home.stateVersion = "25.11";
}
