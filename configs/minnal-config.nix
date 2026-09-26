{ config, pkgs, ... }:
{
  imports =
    [ 
      ../addons/commons.nix
      ../addons/access-control.nix
      ../addons/search-engines.nix
    ];
  # DE
  services.xserver.desktopManager.lxqt.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.enable = true;
  # packages
  environment.systemPackages = [
    pkgs.mullvad-browser
    pkgs.librewolf
    pkgs.gnome-terminal
    pkgs.android-tools
    pkgs.btop
    pkgs.git
    pkgs.obsidian
    pkgs.localsend
    pkgs.libreoffice
    pkgs.tutanota-desktop
    pkgs.bitwarden-desktop
  ];
  programs.kdeconnect.enable = true;
}
