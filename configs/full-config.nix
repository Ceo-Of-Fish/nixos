{ config, pkgs, ... }:
{
  imports =
    [ 
      ../addons/commons.nix
      ../addons/access-control.nix
      ../addons/ai.nix
      ../addons/search-engines.nix
    ];
  # Cinnamon
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.enable = true;
  
  # Linux Mainline Kernal
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # Packages
  services.mullvad-vpn.enable = true;
  environment.systemPackages = [
    pkgs.orca-slicer
    pkgs.hyfetch
    pkgs.nextcloud-client
    pkgs.godot_4
    pkgs.mullvad-browser
    pkgs.librewolf
#    pkgs.ladybird ## tempary commented due to the CVE-2026-58592 issue; very high risk and makes nixos mark it as inscure.
    pkgs.vesktop
    pkgs.thunderbird
    pkgs.gnome-terminal
    pkgs.rustdesk
    pkgs.obs-studio
    pkgs.kdePackages.kdenlive
    pkgs.yt-dlp
    pkgs.video-downloader
    pkgs.android-tools
    pkgs.btop
    pkgs.git
    pkgs.obsidian
    pkgs.localsend
    pkgs.libreoffice
    pkgs.vscode
    pkgs.github-cli
    pkgs.wine
    pkgs.winetricks
    pkgs.lutris
    pkgs.tutanota-desktop
    pkgs.stremio-linux-shell
    pkgs.bitwarden-desktop
    pkgs.krita
    pkgs.gimp
    pkgs.inkscape 
    pkgs.quick-webapps
    pkgs.prismlauncher
  ];
  
  programs.kdeconnect.enable = true;
   
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
 
  # Obs
  programs.obs-studio.enableVirtualCamera = true;
}
