{ lib, ... }:
{
  programs.home-manager.enable = true;

  # Get rid of any home manager backups, because they will prevent new backups from being generated
  # find ~              Search the home directory
  # ! -readable         Match files or directories that are not readable by your user
  # -prune              Don’t descend into those unreadable directories
  # -o                  Or
  # -name '*.hmbackup'  Match files with names ending in .hmbackup
  # -exec rm {} +       Delete all matching files
  home.activation.clearBackups = lib.hm.dag.entryAfter [ ] ''
    find ~ ! -readable -prune -o -name '*.hmbackup' -exec rm {} +
  '';

  # It is occasionally necessary for Home Manager to change configuration defaults
  # in a way that is incompatible with stateful data. This could, for example,
  # include switching the default data format or location of a file.
  # The state version indicates which default settings are in effect and will therefore
  # help avoid breaking program configurations. Switching to a higher state version
  # typically requires performing some manual steps, such as data conversion or moving files.
  home.stateVersion = "24.05";
}
