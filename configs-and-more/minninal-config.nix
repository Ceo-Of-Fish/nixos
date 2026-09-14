{ config, pkgs, ... }:
{
# 1. services -----------------------
  services.xserver.desktopManager.lxqt.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  services.flatpak.enable = true;
  
  # Networking 
  networking.networkmanager.enable = true;
  # same as manully setting it in /etc/resolv.conf, will go onto next option is first isn't working.
  networking.nameservers = [ "194.242.2.3" "1.1.1.1" "8.8.8.8" ]; # mullvad adblock dns, cloudflare dns, google dns
  
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
    size = 4*1024; # 4GiB
  }];
  
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

  users.users.banana = {
    isNormalUser = true;
    description = "banana";
    
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
    ];
  };
  environment.systemPackages = [
    pkgs.home-manager # note that if ZSH isn't enabled, you will need to add "-f /etc/nixos/home.nix" to the end of home-manager switch
    ## browsers/browser related stuff.
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
 

  # Enable the NetBird client service
  services.netbird = {
    enable = true;
    
    # Automatically login using a setup key (recommended for servers)
    # Ensure the setup key file is not copied to the Nix store if reusable
#    login = {
#      enable = true;
#      setupKeyFile = "/path/to/your/setup-key"; 
#    };

#    # Open firewall ports for direct P2P connections
#    openFirewall = true;
#    openInternalFirewall = true;

    # Optional: Enable the GUI client
    ui.enable = true;
  };
}
