{ config, pkgs, ... }:
{
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
