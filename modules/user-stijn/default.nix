{
  users.stijn = {
    name = "Stijn Ruts";
    hostConfig = { pkgs, ... }: {
      # TODO
      environment.systemPackages = with pkgs; [
        yazi
        helix
        git
        lazygit
      ];
    };
    # userConfig = { # TODO
      # you can access the full NixOS configuration at config.nixos (or config.nixosSystem depending on HM version
      # imports = [
        # self.homeModules.foobar
      # ];
      # email.git = "git@stijnruts.be";
      # theme = "catppuccin";
    # };
  };
}

