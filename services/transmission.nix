{ config, lib, pkgs, ... }:

let
  incompleteDir = "/mnt/downloads";
in {
  fileSystems.${incompleteDir} =
    { device = "bpool/root/downloads";
      fsType = "zfs";
      options = [ "nofail" ];
    };

  services.transmission.enable = true;
  services.transmission.settings = {
    download-dir = "/mnt/Media/downloads";
    incomplete-dir = incompleteDir;
    incomplete-dir-enabled = true;
    rpc-host-whitelist = "nixhost.4a";
    rpc-whitelist = "127.0.0.1,192.168.23.*,192.168.24.*";
    cache-size-mb = 1024;
    scrape-paused-torrents-enabled = false;
    seed-queue-enabled = true;
    seed-queue-size = 1000;
    umask = 0;
  };

  networking.firewall.allowedTCPPorts = [ 9091 51413 ];
  networking.firewall.allowedUDPPorts = [ 51413 ];
}
