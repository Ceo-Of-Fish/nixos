{ config, pkgs, inputs, ... }:
{ 
  imports =
    [ 
      ./hardware-configuration.nix # reqired
      ./boot/uefi-boot.nix
#      ./bios-boot.nix
        ## Choose one
      ./configs/full-config.nix
#      ./configs/minnal-config.nix 
#      ./configs/tty-config.nix
        ## Device specifc items 
#      ./configs/X140e-config.nix # Wip
#      ./configs/Surface-Pro-4-config.nix # Wip 
    ];
}
