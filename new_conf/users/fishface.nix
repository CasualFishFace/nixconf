{ mkUser, ... }: mkUser "fishface" {
  isNormalUser = true;
  description = "CasualFishFace";
  extraGroups = [ "networkmanager" "wheel" "video" ];
}
