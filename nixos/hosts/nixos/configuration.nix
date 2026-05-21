{ config, pkgs, username, hostname, ... }:

{
  imports = [
    ../../modules/nix.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "UTC";
  i18n.defaultLocale = "he_IL.UTF-8";

  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = "Primary user";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    gh
    glab
    micro
    wget
    curl
    htop
  ];

  programs.ssh.startAgent = true;

  # First install version. Do not change after install.
  # See https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.11";
}
