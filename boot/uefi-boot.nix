{ config, ... }:
{ 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine = {
    enable = true;
    maxGenerations = 15;
    efiInstallAsRemovable = true; # Some devices may need this to boot correctly, note this will not work on bios machines
  };
}
