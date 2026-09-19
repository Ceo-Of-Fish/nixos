{ config, inputs, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
  
    languagePacks = [ "en-US" ];
  
    profiles.banana = {
      settings = {
        "browser.startup.homepage" = "http://172.0.0.1:8888";
        "privacy.resistFingerprinting" = true;
      };
  
      search = {
        engines = {
          searx = {
            name = "SearXNG";
            urls = [
              {
                template = "http://127.0.0.1:8888/search?q={searchTerms}";
              }
            ];
            iconMapObj."16" =
              "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/searxng.svg";
            definedAliases = [ "@searx" ];
          };
        };
  
        default = "searx";
      };
  
      extensions.packages =
        with inputs.firefox-addons.packages.${pkgs.system};
        [
          ublock-origin
          bitwarden
        ];
    };
  
  policies = {
    DisableTelemetry = true;
  };
};


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "banana";
  home.homeDirectory = "/home/banana";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/banana/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  dconf.settings = {
    "org/cinnamon/desktop/background" = {
      "picture-uri" = "file:///etc/nixos/home-manager/assets/drawing.svg";
      "picture-options" = "zoom";
      "color-shading-type" = "solid";
      "primary-color" = "#000000";
      "secondary-color" = "#000000";
    };
    "org/cinnamon/desktop/interface" = {
      gtk-theme = "Mint-Y-Dark-Blue";
      icon-theme = "Mint-Y-Blue";
      color-scheme = "prefer-dark";
    };

    "org/cinnamon/desktop/wm/preferences" = {
      theme = "Mint-Y-Dark-Blue";
    };

    "org/cinnamon/theme" = {
      name = "Mint-Y-Dark-Blue";
    };
  };



  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

