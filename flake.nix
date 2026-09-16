{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    xlibre-overlay.url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-26.11";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.banana = ./home.nix;
            }
            inputs.xlibre-overlay.nixosModules.overlay-xlibre-xserver

            # Overlay all drivers in this repo
            inputs.xlibre-overlay.nixosModules.overlay-all-xlibre-drivers
            # Instead of `overlay-all-xlibre-drivers` above, user can also choose the drivers invidivually for overlay if something breaks
            # All available drivers are listed in `./packages-reference.nix`, just prepend the key with "overlay-" like below
            # Examples:
            # inputs.xlibre-overlay.nixosModules.overlay-xlibre-xf86-input-evdev
            # inputs.xlibre-overlay.nixosModules.overlay-xlibre-xf86-input-libinput
            # inputs.xlibre-overlay.nixosModules.overlay-xlibre-xf86-video-amdgpu
            # ...

            # Overlay xpra in this repo
            # xpra have to be overlayed to install
            inputs.xlibre-overlay.nixosModules.overlay-xpra
          ];
        };
      };
    };
}
