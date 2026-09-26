{ pkgs, config, ... }:
{
    # Searxng - SearXNG is a free internet metasearch engine which aggregates results from various search services and databases. Users are neither tracked nor profiled.
  environment.systemPackages = with pkgs; [
    searxng
  ];
  services.searx = {
    enable = true;
    settings = {
      search = {
        formats = [
          "html"
          "json"
        ];
      };
      server = {
        port = 8888;
        bind_address = "127.0.0.1";
        secret_key = "X*9yZnAkl9^m^FwoMg^nYLRNqU&"; # random key I gen, change if you want
      };
      general = {
        debug = false;
        instance_name = "Ceo Of Fish SearXNG Instance";
        donation_url = false;
        contact_url = false;
        privacypolicy_url = false;
        enable_metrics = false;
      };

      ui = {
        infinite_scroll = true;
        center_alignment = true;
        default_theme = "simple";
        theme_args.simple_style = "black";
        search_on_category_select = false;
      };
      outgoing = {
        request_timeout = 7.0; # I have bad WiFi, increase or decrease based on needs
        max_request_timeout = 15.0;
      };
      engines = [
        {
          name = "bing";
          disabled = false;
          weight = 0.4;
        }

#        {
#          name = "example";
#          disabled = true/false; # note, setting this to false will cause the search engine to be enabled by default.
#          weight = 0.4;
#        }
      ];
    };
  };

    # Hister - Your Own Search Engine
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
