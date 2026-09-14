{ config, ... }:
{ 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine = {
    enable = true;
    maxGenerations = 15;
    efiInstallAsRemovable = true; # Some devices may need this to boot correctly
  };
  ## Enable the items below if using bios and comment the ones above.
#  boot.loader.grub = {
#    enable = true;
#    device = "/dev/sda";
#  };
}
