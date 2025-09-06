{ pkgs, lib, ... }:

let
  inherit (pkgs) stdenvNoCC autoPatchelfHook makeWrapper patchelf;
in
stdenvNoCC.mkDerivation rec {
  pname = "goneovim";
  version = "0.6.16-bin";

  src = ../../goneovim-v0.6.16-linux;

  nativeBuildInputs = [ autoPatchelfHook makeWrapper patchelf ];
  autoPatchelfIgnoreMissingDeps = [ "libtiff.so.5" ];

  # Libraries required by the prebuilt goneovim (from ldd)
  buildInputs = with pkgs; [
    # X11 + XCB stack
    xorg.libX11
    xorg.libSM
    xorg.libICE
    xorg.libxcb
    xorg.xcbutilwm           # libxcb-icccm
    xorg.xcbutilimage        # libxcb-image
    xorg.xcbutilkeysyms      # libxcb-keysyms
    xorg.xcbutilrenderutil   # libxcb-render-util

    # Wayland + input
    wayland
    libxkbcommon

    # Graphics + fonts
    libGL
    libtiff
    fontconfig
    freetype

    # Core libs
    glib
    pcre2
    zstd
    stdenv.cc.cc             # libstdc++
  ];

  installPhase = ''
    runHook preInstall
    install -Dm0755 "$src/goneovim" "$out/bin/goneovim"
    runHook postInstall
  '';

  # Ensure a predictable runtime for Wayland/X11; keep minimal by default
  # Users can export additional vars as needed.
  postFixup = ''
    # Replace required SONAME for libtiff to match nixpkgs (libtiff.so.6) before wrapping
    ${patchelf}/bin/patchelf --replace-needed libtiff.so.5 libtiff.so.6 "$out/bin/goneovim" || true
    wrapProgram "$out/bin/goneovim" \
      --set-default GIO_EXTRA_MODULES "${pkgs.glib-networking}/lib/gio/modules" \
      --set-default XDG_DATA_DIRS "${pkgs.gsettings-desktop-schemas}/share:${pkgs.gtk3}/share:${pkgs.shared-mime-info}/share"
  '';

  meta = with lib; {
    description = "Goneovim prebuilt binary (0.6.16) patched for NixOS";
    homepage = "https://github.com/akiyosi/goneovim";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [];
  };
}
