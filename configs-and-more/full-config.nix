{ config, pkgs, ... }:
{
  # 1. services -----------------------
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # lets you see the battery % on supported devices.
        Experimental = true;
        # Allows faster connection at the cost of more batter useage.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true
      ;};
    };
  };

  services.flatpak.enable = true;
  
  # Networking 
  networking.networkmanager.enable = true;
  # same as manully setting it in /etc/resolv.conf, will go onto next option is first isn't working.
#  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ]; # mullvad adblock dns, cloudflare dns, google dns
  

  # Docker
  virtualisation.docker = {
    enable = true;    
  };
  
  # Mullvad VPN
  services.mullvad-vpn.enable = true;

  services.xserver.enable = true; #cinnamon uses x11 by default

  services.printing.enable = true;

  # Pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

# 2. settings/options -----------------------
  
  #swap file
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8*1024; # 8 GiB
  }];
  
  # set the linux kernal verison: the common ones are linux, linux_latest, linux_lts
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #allows the use of flakes without needing to allow everytime
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = [ "banana" ];
    # Optional, retains environment variables while running commands 
    # e.g. retains your NIX_PATH when applying your config
    keepEnv = true; 
    persist = true;  # Optional, only require password verification a single time
  }];

  networking.hostName = "nixos";

    networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 22 ];
#  allowedUDPPortRanges = [
#      { from = 4000; to = 4007; }
#      { from = 8000; to = 8010; }
#    ];
  };

  #some basic stuff
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # auto deletes nix generations oldet than x days
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # auto updates to nixos-unstable and attemtes to update apps everyday
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "daily";
  
  # this doesn't auto update the verison but should be changed when updated to a newer verison
  system.stateVersion = "26.11";
  # 3. apps/user apps 

  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = [
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

  services.ollama = {
    enable = true;
    # Optional: preload models, see https://ollama.com/library
    #loadModels = [ ];
  };

}
