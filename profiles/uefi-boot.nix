{ config, pkgs, ... }:

{

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "usbhid"
    "sd_mod"
    "sdhci_acpi"
    "r8169"
    "tpm"
    "mii"
    "tpm_tis"
  ];

  boot.initrd.supportedFilesystems = [
    "zfs"
    "nfs"
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

}
