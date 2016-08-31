{ config, lib, pkgs, ... }:

{
  systemd.services.sonarr = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      TimeoutStartSec = 0;
      Restart = "always";
      ExecStartPre = [
        ''-${pkgs.docker}/bin/docker pull linuxserver/sonarr''
        ''-${pkgs.docker}/bin/docker rm -f sonarr''
      ];
      ExecStart = ''${pkgs.docker}/bin/docker run \
        --rm \
        --net="host" \
        -p 8989:8989 \
        -e PUID=1000 -e PGID=100 \
        -v /dev/rtc:/dev/rtc:ro \
        -v /mnt/Media/TV:/tv \
        -v /mnt/storage/downloads/.sonarr:/downloads \
        -v /mnt/oldnix/home/grw/sonarr_config:/config \
        linuxserver/sonarr'';
      ExecStop = ''${pkgs.docker}/bin/docker rm -f sonarr'';
    };
  };
}
