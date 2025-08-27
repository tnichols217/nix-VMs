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
        "-device virtio-vga-pci"
        # "-display sdl,gl=on,show-cursor=off"
        "-vga none"
        "-device qxl-vga"
        "-display none"
        "-spice port=5900,addr=127.0.0.1,disable-ticketing"
        "-chardev spicevmc,id=charchannel0,name=vdagent"
        # Wire up pipewire audio
        "-audiodev pipewire,id=audio0"
        "-device intel-hda"
        "-device hda-output,audiodev=audio0"
      ];
    };
  };
  environment.sessionVariables = lib.mkVMOverride {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };
}