{ config, pkgs, ... }:
let
  configs = "${config.home.homeDirectory}/working/configs";
  link = path: config.lib.file.mkOutOfStoreSymlink "${configs}/${path}";
in
{
  home = {
    username = "jwi";
    homeDirectory = "/home/jwi";
    stateVersion = "26.05";
  };
  programs.home-manager.enable = true;

  # out-of-store: files stay editable, nvim rewrites its own lock files
  home.file = {
    ".bashrc".source = link "bash/.bashrc";
    ".bash_aliases".source = link "bash/.bash_aliases";
    ".gitconfig".source = link "git/.gitconfig";
    ".profile".source = link "bash/.profile";
    ".config/nvim".source = link "nvim/.config/nvim";
    ".config/regolith3/Xresources".source = link "regolith3/.config/regolith3/Xresources";
  };

  # cli only, nothing that needs graphics (CUDA stays handled by popos)
  home.packages = with pkgs; [
    # shell
    btop
    direnv
    ripgrep
    fzf
    fd
    jq

    # editor + git
    neovim
    lazygit
    git

    # mason installs node-based language servers
    nodejs

    # python
    uv
    ruff

    # nix tooling
    statix
    nixfmt

    # build + cloud
    go
    bazelisk
    awscli2
    runpodctl

    # nixpkgs ships the launcher as `bazelisk` therefore an alias.
    (pkgs.runCommand "bazel-as-bazelisk" { } ''
      mkdir -p $out/bin
      ln -s ${pkgs.bazelisk}/bin/bazelisk $out/bin/bazel
    '')
  ];
}
