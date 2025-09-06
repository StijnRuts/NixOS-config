{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.ollama.models = lib.mkOption {
    type = lib.types.enum [
      "light"
      "heavy"
    ];
    default = "light";
    description = "Sets which Ollama models should be loaded by default";
  };

  config = {
    environment.systemPackages = lib.mkIf config.apps.utilities.enable [
      pkgs.alpaca
      # (writeShellScriptBin "chat" "ollama run qwen2.5:0.5b")
      # (writeShellScriptBin "code" "ollama run qwen2.5-coder:0.5b")
      # (writeShellScriptBin "codefile" "ollama run qwen2.5-coder:0.5b < \"$@\"")
    ];

    services.ollama = {
      inherit (config.apps.utilities) enable;
      loadModels =
        {
          "light" = [
            "qwen2.5:0.5b"
            "qwen2.5-coder:0.5b"
          ];
          "heavy" = [
            "llama3.2:3b"
            "codellama:13b"
            "deepseek-llm:7b"
            "deepseek-coder-v2:16b"
          ];
        }
        .${config.ollama.models};
    };

    persist.system = {
      directories = [
        {
          directory = "/var/lib/private/ollama";
          mode = "0700";
        }
      ];
    };
    persist.home = {
      directories = [
        ".ollama"
        ".local/share/com.jeffser.Alpaca"
      ];
    };
  };
}
