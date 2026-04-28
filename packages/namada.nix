{
  pkgs,
  namada-src,
}: let
  rust =
    (pkgs.rust-bin.stable."1.85.1".default.override {
      targets = ["wasm32-unknown-unknown"];
    }).overrideAttrs (old: {
      targetPlatforms = ["x86_64-linux" "wasm32-unknown-unknown"];
      badTargetPlatforms = [];
    });
  rustPlatform = pkgs.makeRustPlatform {
    cargo = rust;
    rustc = rust;
  };
in
  rustPlatform.buildRustPackage {
    pname = "namada";
    version = "v201.0.8";
    src = namada-src;
    RUSTUP_TOOLCHAIN = "1.85.1";
    nativeBuildInputs = with pkgs;
      (
        if stdenv.isLinux
        then [pkg-config]
        else [darwin.apple_sdk.frameworks.Security]
      )
      ++ [
        protobuf
        rustPlatform.bindgenHook # required for bindgen in custom build script for librocksdb-sys
      ];
    buildInputs = with pkgs;
      [
        openssl
        openssl.dev
      ]
      ++ lib.optionals stdenv.isLinux [
        systemd # required for libudev in custom build script for hidapi
      ]
      ++ lib.optionals stdenv.isDarwin [
        libusb
        hidapi
      ];

    cargoLock.lockFile = "${namada-src}/Cargo.lock";

    postPatch = ''
      ${pkgs.python3}/bin/python3 <<'PY'
      from pathlib import Path

      rocksdb_root = Path("/build/cargo-vendor-dir/librocksdb-sys-0.17.1+9.9.3/rocksdb")
      headers = list(rocksdb_root.rglob("*.h"))

      for header in headers:
          text = header.read_text()
          if "#include <cstdint>\n" in text or "#include <stdint.h>\n" in text:
              continue
          if "uint32_t" not in text and "uint64_t" not in text:
              continue

          lines = text.splitlines(keepends=True)
          insert_at = 0
          for idx, line in enumerate(lines):
              if line.startswith("#include "):
                  insert_at = idx + 1
          lines.insert(insert_at, "#include <cstdint>\n")
          header.write_text("".join(lines))
      PY
    '';

    doCheck = false;
  }
