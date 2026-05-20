{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    tree
  ];

  programs.bash.enable = true;
  programs.starship.enable = true;

  # First install version. Do not change after install.
  home.stateVersion = "24.11";
}
