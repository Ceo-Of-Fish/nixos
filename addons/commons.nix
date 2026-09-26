# These are the common items that every config uses so its easier to have it here, yes it is a mess, no I don't care
{ config, pkgs, ... }:
{
  services.flatpak.enable = true;
  networking.networkmanager.enable = true;
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
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  #swap file
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4*1024; # 4GiB
  }];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  users.users.banana = {
    isNormalUser = true;
    description = "banana";
    
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
    ];
  };
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
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "daily";
  system.stateVersion = "26.11";
  nixpkgs.config.allowUnfree = true;
  services.printing.enable = true;

    # ZSH asdkudsafgsafgfgdsagjdsagfdsgfdhgdfdsjdsgfjfjsasahgfjgdsafgjdsafgdsgkjhgfa
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cd = "z";
      ll = "ls -l";
      appimage = "nix-shell -p appimage-run";
      update = "flatpak update --assumeyes && doas nixos-rebuild switch";
      mc = "mullvad connect && exit";
      mr = "mullvad reconnect";
      md = "mullvad disconnect && exit";
      hm = "home-manager switch -f /etc/nixos/home.nix";
    };
  };
users.users.banana = {
#    isNormalUser = true;
    shell = pkgs.zsh;
  };

 # Enables zoxide
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  # Starship 
  programs.starship = {
    enable = true;
    
    # This automatically generates the starship.toml file for you
    settings = {
      add_newline = false;
      
      # Example customization: changing the prompt symbol
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      # Example: Customize the directory display
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
      };
    };
  };

  # 4. (Optional) Add a Nerd Font so Starship icons render correctly
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code  # Or whichever font you prefer
  ];
}
