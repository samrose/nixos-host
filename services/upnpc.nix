{ config, lib, pkgs, ... }:

{
      systemd.services.upnpc_map =
      {
        description = "Run upnpc to redirect port 22";
        serviceConfig.ExecStart = "${pkgs.miniupnpc}/bin/upnpc -r 22 tcp";
        startAt = "00:00";
        serviceConfig.Type = "oneshot";
      };

}
