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
        cores = 4;
        graphics = true;
      };
      virtualisation.qemu.options = [
        "-device virtio-gpu"
        "-vga virtio"
        # "-display sdl,gl=on,show-cursor=off"
        # "-vga none"
        # Wire up pipewire audio
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