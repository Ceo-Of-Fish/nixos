{ config, ... }:
{
  services.openssh = {
  enable = true;
  openFirewall = true;
  settings = {
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = true;
    PermitRootLogin = "no";
    AllowUsers = [ "banana" "root"];
    MaxAuthTries = 3;
    PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
    };
  };
  users.users.banana.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOQv77sdYeIbtfALLxbiumReGxlJLB21oCRD5lnrThLj banana" 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOQv77sdYeIbtfALLxbiumReGxlJLB21oCRD5lnrThLj root"
  ];


  # Enable the NetBird client service
  services.netbird = {
    enable = true;
    ui.enable = true;
  };
}
