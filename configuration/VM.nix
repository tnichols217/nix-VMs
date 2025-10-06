{ modulesPath, lib, ... }:
{
  imports = [
    (modulesPath + "/virtualisation/qemu-vm.nix")
  ];
  hardware.graphics.enable = true; 
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  virtualisation = {
    useEFIBoot = true;
    vmVariant = {
      virtualisation = {
        memorySize = 16384;
        cores = 8;
        graphics = true;
      };
      virtualisation.qemu.options = [
        "-device virtio-gpu"
        "-vga virtio"
        "-audiodev pipewire,id=audio0"
        "-device intel-hda"
        "-device hda-output,audiodev=audio0"
      ];
    };
  };
  environment.sessionVariables = lib.mkVMOverride {
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}