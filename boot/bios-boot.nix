{ config, ... }:
{ 
  boot.loader.limine = {
    enable = true;
    biosDevice = "/dev/sda";
    maxGenerations = 15;
  };
}
