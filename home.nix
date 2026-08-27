{
  config,
  pkgs,
  lib,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  envUser = builtins.getEnv "USER";
  envHome = builtins.getEnv "HOME";
  requireImpure =
    name: value:
    if value == "" then
      throw ("home.nix: $" + name + " is empty - run home-manager with --impure")
    else
      value;
  configs = "${config.home.homeDirectory}/working/configs";
  link = path: config.lib.file.mkOutOfStoreSymlink "${configs}/${path}";
in
{
  home = {
    username = requireImpure "USER" envUser;
    homeDirectory = requireImpure "HOME" envHome;
    stateVersion = "26.11";
  };
  programs.home-manager.enable = true;

  # out-of-store: files stay editable, nvim rewrites its own lock files
  home.file = {
    ".bashrc".source = link "bash/.bashrc";
    ".bash_aliases".source = link "bash/.bash_aliases";
    ".gitconfig" = {
      source = link "git/.gitconfig";
      force = true;
    };
    ".profile".source = link "bash/.profile";
    ".config/nvim".source = link "nvim/.config/nvim";
  }
  // lib.optionalAttrs (!isDarwin) {
    # Regolith 3 is Linux-only
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
    awscli2
    runpodctl

    # nixpkgs ships the launcher as `bazelisk` therefore an alias.
    # Linked by hand rather than installing pkgs.bazelisk: that package also
    # ships a `sha256sum` which shadows coreutils' on PATH and prints the hash
    # without the filename column, breaking `sha256sum -c` and any parser that
    # splits on whitespace (e.g. blink.cmp's pre-built binary check).
    (pkgs.runCommand "bazelisk-no-sha256sum" { } ''
      mkdir -p $out/bin
      ln -s ${pkgs.bazelisk}/bin/bazelisk $out/bin/bazelisk
      ln -s ${pkgs.bazelisk}/bin/bazelisk $out/bin/bazel
    '')
  ];
}
