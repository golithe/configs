{ pkgs, ... }:
{
  home.username = "jwi";
  home.homeDirectory = "/home/jwi";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    btop
    ripgrep
    fzf
    fd
  ];
}
