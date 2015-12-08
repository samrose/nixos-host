{ config, lib, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
    socketActivation = false;
    extraOptions = "-H tcp://127.0.0.1:2375 -H unix:///var/run/docker.sock";
  };
}
