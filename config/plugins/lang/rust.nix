{ pkgs, ... }:
{
  plugins = {
    conform-nvim = {
      settings = {
        formatters_by_ft.rust = [ "rustfmt" ];
      };
    };

    rustaceanvim = {
      enable = true;

      settings = {
        server = {
          default_settings = {
            inlayHints = {
              lifetimeElisionHints = {
                enable = "always";
              };
            };
            rust-analyzer = {
              cargo = {
                allFeatures = true;
              };
              check = {
                command = "clippy";
              };
              files = {
                excludeDirs = [
                  "target"
                  ".git"
                  ".cargo"
                  ".github"
                  ".direnv"
                ];
              };
            };
          };
        };
      };
    };
  };

  extraPackages = with pkgs; [
    rust-analyzer
    clippy
    rustfmt
  ];
}
