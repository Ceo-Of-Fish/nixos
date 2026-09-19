{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    searxng
  ];
  services.searx = {
    enable = true;
    settings = {
      server = {
        port = 8888;
        bind_address = "127.0.0.1";
        secret_key = "X*9yZnAkl9^m^FwoMg^nYLRNqU&"; # random key I gen, change if you want
      };
    };
  };
}
