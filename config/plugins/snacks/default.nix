_: {
  imports = [
    ./bigfile.nix
    ./gitbrowse.nix
  ];

  plugins = {
    snacks = {
      enable = true;

      settings = {
        image.enabled = true;
        indent.enabled = true;
        scroll.enabled = true;
      };
    };
  };
}
