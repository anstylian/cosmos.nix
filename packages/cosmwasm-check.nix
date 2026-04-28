{
  lib,
  stdenv,
  curl,
  fetchFromGitHub,
  pkg-config,
  openssl,
  makeRustPlatform,
  rust-bin,
}: let
  rustToolchain = rust-bin.stable."1.86.0".default;
  rustPlatform = makeRustPlatform {
    cargo = rustToolchain;
    rustc = rustToolchain;
  };
in
  rustPlatform.buildRustPackage rec {
    pname = "cosmwasm-check";
    version = "v3.0.2";

    src = fetchFromGitHub {
      owner = "CosmWasm";
      repo = "cosmwasm";
      tag = "${version}";
      hash = "sha256-UcMvmQ5tVuSIufq+KtMeaEIDLciWhnV+ToNcthYr1N0=";
    };

    cargoBuildFlags = [
      "-p"
      "cosmwasm-check"
    ];

    cargoHash = "sha256-iBMjoYGSxOMV2oO6bDgQwjk9i0wx+2sp0ltmjLtNOBk=";

    nativeBuildInputs = [pkg-config];

    buildInputs = [openssl] ++ lib.optionals stdenv.hostPlatform.isDarwin [curl];

    checkFlags = [
      "skip=results::events::tests::attribute_new_reserved_key_panicks"
      "skip=results::events::tests::attribute_new_reserved_key_panicks2"
    ];

    meta = {
      description = "CosmWasm check tool for verifying contract compliance with CosmWasm standards";
      homepage = "https://github.com/CosmWasm/cosmwasm";
    };
  }
