{ config, pkgs, inputs, ... }:
# List of contents:
# 1. services
# 2. settings/options
# 3. apps/user apps
# 4. ZSH
{ 
  imports =
    [ 
      ./hardware-configuration.nix
      ./configs-and-more/full-config.nix # full config 
      #./configs-and-more/minninal-config.nix # minninal config
      ./configs-and-more/zsh.nix # zsh config, can be disabled if wanted.
      ./configs-and-more/users.nix # control the users
      ./configs-and-more/boot.nix # controls the boot
    ];
}
