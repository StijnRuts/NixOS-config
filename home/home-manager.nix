{
  config,
  pkgs,
  lib,
  me,
  ...
}:
{
  programs.home-manager.enable = true;
  home.username = "${me.username}";
  home.homeDirectory = "/home/${me.username}";

  # Get rid of any home manager backups, because they will prevent new backups from being generated
  home.activation.clearBackups = lib.hm.dag.entryAfter [ ] ''
    if [ -n "\$\{DRY_RUN:-\}" ]; then
      echo "Running before Home Manager activates..."
      find ~ -name '*.hmbackup' -delete
    fi
  '';

  # It is occasionally necessary for Home Manager to change configuration defaults
  # in a way that is incompatible with stateful data. This could, for example,
  # include switching the default data format or location of a file.
  # The state version indicates which default settings are in effect and will therefore
  # help avoid breaking program configurations. Switching to a higher state version
  # typically requires performing some manual steps, such as data conversion or moving files.
  home.stateVersion = "24.05";
}
