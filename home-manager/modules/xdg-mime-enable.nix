{
  # Nautilus crashes while opening folders containing js or json files (Ubunutu 22.04.4 LTS / home-manager 24.11-pre)
  # 
  # Issue: Crash when opening folders with js or json that have content 
  # https://gitlab.gnome.org/GNOME/nautilus/-/issues/3273
  # 
  # Fix (temporarily):
  # https://github.com/nix-community/home-manager/issues/4682#issuecomment-1841994950
  xdg.mime.enable = false;
}
