{
  outputs = inputs: {
    nixosModules.rewritefs = {

      programs.fuse = {
        enable = true;
        userAllowOther = true;
      };

#    rewritefs -o config=/mnt/home/me/.config/rewritefs /mnt/home/me /home/me

#    m#^(?!\.)# .
#    m#^\.(cache|config|local)# .
#    m#^\.# .config/

    };
  };
}
