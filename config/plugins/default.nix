{
  imports = [
    ./completion/blink.nix
    ./completion/friendly-snippets.nix
    ./completion/lspkind.nix

    ./editor/lz-n.nix
    ./editor/neotree.nix
    ./editor/whichkey.nix

    ./theme
    ./luasnip

    ./snacks

    ./telescope

    ./git/gitsigns.nix

    ./lsp/conform.nix
    ./lsp/fastaction.nix
    ./lsp/lsp.nix
    ./lsp/lspsaga.nix
    ./lsp/trouble.nix

    ./lang/cpp.nix
    ./lang/css.nix
    ./lang/docker.nix
    ./lang/html.nix
    ./lang/json.nix
    ./lang/lua.nix
    ./lang/markdown.nix
    ./lang/nix.nix
    ./lang/rust.nix
    ./lang/python.nix
    ./lang/shell.nix
    ./lang/typescript.nix
    ./lang/yaml.nix

    ./treesitter/treesitter.nix
    ./treesitter/treesitter-textobjects.nix

    ./ui/alpha.nix
    ./ui/bufferline.nix
    ./ui/general.nix
    ./ui/flash.nix
    ./ui/indent-blankline.nix
    ./ui/lualine.nix
    ./ui/noice.nix
    ./ui/notify.nix
    ./ui/toggleterm.nix
    ./ui/precognition.nix
    ./ui/ufo.nix

    ./util/colorizer.nix
    ./util/compiler.nix
    ./util/debugprint.nix
    ./util/mini.nix
    ./util/nvim-surround.nix
    ./util/plenary.nix
    ./util/persistence.nix
    ./util/project-nvim.nix
    ./util/package-info.nix
  ];
}
