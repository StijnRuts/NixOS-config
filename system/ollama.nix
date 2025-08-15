{
  config,
  pkgs,
  me,
  isLaptop,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    alpaca
    (writeShellScriptBin "chat" "ollama run qwen2.5:0.5b")
    (writeShellScriptBin "code" "ollama run qwen2.5-coder:0.5b")
    (writeShellScriptBin "codefile" "ollama run qwen2.5-coder:0.5b < \"$@\"")
  ];

  services.ollama = {
    enable = true;
    loadModels =
      if isLaptop then
        [
          "qwen2.5:0.5b"
          "qwen2.5-coder:0.5b"
        ]
      else
        [
          "llama3.2:3b"
          "codellama:13b"
          "deepseek-llm:7b"
          "deepseek-coder-v2:16b"
        ];
  };

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/var/lib/private/ollama";
        mode = "0700";
      }
    ];
    users.${me.username} = {
      directories = [
        ".ollama"
        ".local/share/com.jeffser.Alpaca"
      ];
    };
  };
}
