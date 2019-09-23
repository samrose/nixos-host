{ config, pkgs, ... }:

{
  imports  = [
    ../modules/auto-rotate.nix
  ];

  boot.initrd.kernelModules = [ "acpi" "thinkpad-acpi" "acpi-call" ];
  boot.kernelParams = [
    "nopti"
    "nospectre_v2"
    "l1tf=off"
    "nospec_store_bypass_disable"
    "no_stf_barrier"
  ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.acpi_call
    config.boot.kernelPackages.tp_smapi
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    modemmanager
    msr-tools
    networkmanagerapplet
    powertop
    rfkill
  ];

  hardware.bluetooth = {
   enable = true;
   powerOnBoot = false;
  };

  hardware.auto-rotate.enable = true;

  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
    speed = 250;
    sensitivity = 100;
  };

  hardware.pulseaudio.enable = true;

  services.tlp = {
    enable = true;
    # https://github.com/NixOS/nixpkgs/issues/46048
    extraConfig = ''
      CPU_SCALING_GOVERNOR_ON_AC=ondemand
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
    '';
  };

  services.xserver.libinput = {
    enable = true;
    accelSpeed = "0.1";
    naturalScrolling = true;
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  sound.mediaKeys.enable = true;

  # need networkmanager for wwan
  networking.networkmanager = {
    enable = true;
    unmanaged = [
      "docker0"
      "rndis0"
    ];
  };

  systemd.services.modem-manager.enable = true;
  systemd.services.ModemManager = {
    wantedBy = [ "multi-user.target" ];
  };

}
