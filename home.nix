{ pkgs, ... }:
{
  home = {
    username = "jwi";
    homeDirectory = "/home/jwi";
    stateVersion = "26.05";
  };
  programs.home-manager.enable = true;

  # cli only, nothing that needs graphics (CUDA stays handled by popos)
  home.packages = with pkgs; [
    # shell
    btop
    ripgrep
    fzf
    fd

    # editor + git
    neovim
    lazygit

    # nix tooling
    statix
    nixfmt

    # build + cloud
    go
    bazelisk
    awscli2

    # nixpkgs ships the launcher as `bazelisk` therefore an alias.
    (pkgs.runCommand "bazel-as-bazelisk" { } ''
      mkdir -p $out/bin
      ln -s ${pkgs.bazelisk}/bin/bazelisk $out/bin/bazel
    '')
  ];
}
