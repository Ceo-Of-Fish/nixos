{ pkgs, config, ... }:
{
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  nixpkgs.config.allowUnfree = true; # proprietary drivers
  boot.kernelModules = [ "wl" ]; # set of kernel modules loaded in second stage of boot process
  boot.initrd.kernelModules = [ "kvm-intel" "wl" ]; # list of modules always loaded by the initrd
}
