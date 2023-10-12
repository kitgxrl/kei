{ inputs, config, ... }:
let
  ised25519 = k: k.type == "ed25519";
  getkeypath = k: k.path;
  keys = builtins.filter ised25519 config.services.openssh.hostkeys;
in {
  imports = [ inputs.sops-nix.nixosmodules.sops ];

  sops = { age.sshkeypaths = map getkeypath keys; };
}
