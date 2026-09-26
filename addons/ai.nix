{ pkgs, config, ... }:
{
  environment.systemPackages = [
    pkgs.open-webui
  ];
  services.ollama = {
    enable = true;
    # Optional: preload models, see https://ollama.com/library
    loadModels = [ "all-minilm:22m" "llama3.2:3b"];
  };
  services.open-webui = {
    enable = true;
  };
}
