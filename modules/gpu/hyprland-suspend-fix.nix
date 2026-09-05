{ ... }:
let
  nixos = { pkgs, ... }:
    let
      suspendScript = pkgs.writeShellScript "suspend-hyprland" ''
        case "$1" in
          suspend)
            ${pkgs.procps}/bin/pkill -SIGSTOP Hyprland
            ;;
          resume)
            ${pkgs.procps}/bin/pkill -SIGCONT Hyprland
            ;;
        esac
      '';
    in
    {
      systemd.services.hyprland-suspend = {
        description = "Suspend Hyprland before NVIDIA sleeps";
        before = [ "systemd-suspend.service" "systemd-hibernate.service" "nvidia-suspend.service" "nvidia-hibernate.service" ];
        wantedBy = [ "systemd-suspend.service" "systemd-hibernate.service" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${suspendScript} suspend";
        };
      };
      systemd.services.hyprland-resume = {
        description = "Resume Hyprland after NVIDIA wakes";
        after = [ "systemd-suspend.service" "systemd-hibernate.service" "nvidia-resume.service" ];
        wantedBy = [ "systemd-suspend.service" "systemd-hibernate.service" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${suspendScript} resume";
        };
      };
    };
in
{
  flake.modules.nixos.hyprland-suspend-fix-nvidia = nixos;
}
