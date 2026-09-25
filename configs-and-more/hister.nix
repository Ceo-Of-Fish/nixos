{ config, pkgs, ... }:
{
  services.hister = {
    enable = true;

  # Optional: Set via Nix options. These take precedence over the config file.
  # port = 4433;
  # dataDir = "/var/lib/hister";
  # openFirewall = true; # NixOS only
  # configPath = /path/to/config.yml;
  # environmentFile = "/run/secrets/hister.env";

    settings = {
      app = {
        search_url = "http://127.0.0.1:8888/search?q={query}"; # I use searxng so you may wanna change this if you disable searxng!!
        log_level = "info";
      };
      server = {
        address = "127.0.0.1:4433";
        database = "db.sqlite3";
      };
    };
  };
}
