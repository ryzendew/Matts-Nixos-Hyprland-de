{
  description = "Matthew's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    affinity-nix.url = "github:mrshmllow/affinity-nix";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      flake = false;
    };
    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";
    hyprswitch.url = "github:ryzendew/hyprswitch";
    hyprlandde-quickshell = {
      url = "github:ryzendew/HyprlandDE-Quickshell/Stable";
      flake = false;
    };
    nautilus-open-in-ptyxis = {
      url = "github:GustavoWidman/nautilus-open-in-ptyxis";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, chaotic, quickshell, hyprswitch, hyprlandde-quickshell, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ chaotic.overlays.default ];
        config.allowUnfree = true;
      };

      specialArgs = {
        inherit inputs;
        unstablePkgs = pkgs;
        aff = {
          photo = inputs.affinity-nix.packages.${system}.photo;
          designer = inputs.affinity-nix.packages.${system}.designer;
          hyprpolkit = inputs.hyprpolkitagent.packages.${system}.default;
          hyprswitch = inputs.hyprswitch.packages.${system}.default;
          hyprlandde-quickshell = inputs.hyprlandde-quickshell;
          nautilus-open-in-ptyxis = inputs.nautilus-open-in-ptyxis;
        };
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = specialArgs;
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ chaotic.overlays.default ];
          })
          ./hosts/default/hardware-configuration.nix
          chaotic.nixosModules.mesa-git
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.matt = import ./hosts/default/home.nix;
              extraSpecialArgs = specialArgs;
            };
          }
          ./hosts/default/configuration.nix
          ./modules/desktop/desktop-environment.nix
          ./modules/editors/editor-config.nix
          ./modules/programs/system-programs.nix
          ./modules/hyprlandde-quickshell.nix
          ./modules/nautilus-extensions.nix
          ({ pkgs, ... }: {
            environment.systemPackages = [ (pkgs.callPackage quickshell { }) ];
          })
          ./system/system-config.nix
        ];
      };
    };
}
