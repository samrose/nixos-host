{ config, lib, pkgs, ... }:

{

  hardware.enableAllFirmware = true;

  networking.wireless = {
    enable = lib.mkDefault true;
    networks = {
      VM4588425 = {
        psk = "Jd6qrtjwnqrj";
      };
    };
  };

  systemd.services.wpa_supplicant.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  systemd.services.wpa_supplicant.serviceConfig = {
    Restart = "on-failure";
    RestartSec = "5s";
  };

}
