{ config, pkgs, ... }:
{
  users.users.banana = {
    isNormalUser = true;
    description = "banana";
    
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      home-manager
    ];
  };
}
