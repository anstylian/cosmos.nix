{
  inputs,
  system,
  packages,
}: let
  lib = inputs.nixpkgs.lib;
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  scripts = import ../scripts {inherit pkgs;};
  mkApp = {
    package ? null,
    program,
    description ? null,
  }: let
    pkgMeta =
      if package == null
      then {}
      else packages.${package}.meta or {};
  in {
    type = "app";
    inherit program;
    meta =
      pkgMeta
      // {
        description =
          if description != null
          then description
          else pkgMeta.description or "cosmos.nix app ${package}";
      }
      // lib.optionalAttrs (pkgMeta ? platforms) {
        inherit (pkgMeta) platforms;
      };
  };
in
  {
    dydx = mkApp {
      package = "dydx";
      program = "${packages.dydx}/bin/dydxprotocold";
    };
    cometbft = mkApp {
      package = "cometbft";
      program = "${packages.cometbft}/bin/cometbft";
    };
    haqq = mkApp {
      package = "haqq";
      program = "${packages.haqq}/bin/haqqd";
    };
    hermes = mkApp {
      package = "hermes";
      program = "${packages.hermes}/bin/hermes";
    };
    gaia5 = mkApp {
      package = "gaia5";
      program = "${packages.gaia5}/bin/gaiad";
    };
    gaia6 = mkApp {
      package = "gaia6";
      program = "${packages.gaia6}/bin/gaiad";
    };
    gaia6-ordered = mkApp {
      package = "gaia6-ordered";
      program = "${packages.gaia6-ordered}/bin/gaiad";
    };
    gaia7 = mkApp {
      package = "gaia7";
      program = "${packages.gaia7}/bin/gaiad";
    };
    gaia8 = mkApp {
      package = "gaia8";
      program = "${packages.gaia8}/bin/gaiad";
    };
    gaia9 = mkApp {
      package = "gaia9";
      program = "${packages.gaia9}/bin/gaiad";
    };
    gaia10 = mkApp {
      package = "gaia10";
      program = "${packages.gaia10}/bin/gaiad";
    };
    gaia11 = mkApp {
      package = "gaia11";
      program = "${packages.gaia11}/bin/gaiad";
    };
    gaia12 = mkApp {
      package = "gaia12";
      program = "${packages.gaia12}/bin/gaiad";
    };
    gaia13 = mkApp {
      package = "gaia13";
      program = "${packages.gaia13}/bin/gaiad";
    };
    gaia14 = mkApp {
      package = "gaia14";
      program = "${packages.gaia14}/bin/gaiad";
    };
    gaia15 = mkApp {
      package = "gaia15";
      program = "${packages.gaia15}/bin/gaiad";
    };
    gaia17 = mkApp {
      package = "gaia17";
      program = "${packages.gaia17}/bin/gaiad";
    };
    gaia19 = mkApp {
      package = "gaia19";
      program = "${packages.gaia19}/bin/gaiad";
    };
    gaia20 = mkApp {
      package = "gaia20";
      program = "${packages.gaia20}/bin/gaiad";
    };
    gaia-main = mkApp {
      package = "gaia-main";
      program = "${packages.gaia-main}/bin/gaiad";
    };
    ica = mkApp {
      package = "ica";
      program = "${packages.ica}/bin/icad";
    };
    cosmovisor = mkApp {
      package = "cosmovisor";
      program = "${packages.cosmovisor}/bin/cosmovisor";
    };
    simd = mkApp {
      package = "simd";
      program = "${packages.simd}/bin/simd";
    };
    slinky = mkApp {
      package = "slinky";
      program = "${packages.slinky}/bin/slinkyd";
    };
    ibc-go-v7-simapp = mkApp {
      package = "ibc-go-v7-simapp";
      program = "${packages.ibc-go-v7-simapp}/bin/simd";
    };
    ibc-go-v8-simapp = mkApp {
      package = "ibc-go-v8-simapp";
      program = "${packages.ibc-go-v8-simapp}/bin/simd";
    };
    ibc-go-v9-simapp = mkApp {
      package = "ibc-go-v9-simapp";
      program = "${packages.ibc-go-v9-simapp}/bin/simd";
    };
    ibc-go-v10-simapp = mkApp {
      package = "ibc-go-v10-simapp";
      program = "${packages.ibc-go-v10-simapp}/bin/simd";
    };
    ibc-go-v7-wasm-simapp = mkApp {
      package = "ibc-go-v7-wasm-simapp";
      program = "${packages.ibc-go-v7-wasm-simapp}/bin/simd";
    };
    ibc-go-v8-wasm-simapp = mkApp {
      package = "ibc-go-v8-wasm-simapp";
      program = "${packages.ibc-go-v8-wasm-simapp}/bin/simd";
    };
    ignite-cli = mkApp {
      package = "ignite-cli";
      program = "${packages.ignite-cli}/bin/ignite";
    };
    interchain-security = mkApp {
      package = "interchain-security";
      program = "${packages.interchain-security}/bin/interchain-security";
    };
    gm = mkApp {
      package = "gm";
      program = "${packages.gm}/bin/gm";
    };
    osmosis = mkApp {
      package = "osmosis";
      program = "${packages.osmosis}/bin/osmosisd";
    };
    centauri = mkApp {
      package = "centauri";
      program = "${packages.centauri}/bin/centaurid";
    };
    regen = mkApp {
      package = "regen";
      program = "${packages.regen}/bin/regen";
    };
    evmos = mkApp {
      package = "evmos";
      program = "${packages.evmos}/bin/evmosd";
    };
    juno = mkApp {
      package = "juno";
      program = "${packages.juno}/bin/junod";
    };
    sentinel = mkApp {
      package = "sentinel";
      program = "${packages.sentinel}/bin/sentinelhub";
    };
    akash = mkApp {
      package = "akash";
      program = "${packages.akash}/bin/akash";
    };
    umee = mkApp {
      package = "umee";
      program = "${packages.umee}/bin/umeed";
    };
    ixo = mkApp {
      package = "ixo";
      program = "${packages.ixo}/bin/ixod";
    };
    sifchain = mkApp {
      package = "sifchain";
      program = "${packages.sifchain}/bin/sifnoded";
    };
    wasmd = mkApp {
      package = "wasmd";
      program = "${packages.wasmd}/bin/wasmd";
    };
    stride = mkApp {
      package = "stride";
      program = "${packages.stride}/bin/strided";
    };
    stride-no-admin = mkApp {
      package = "stride-no-admin";
      program = "${packages.stride-no-admin}/bin/strided";
    };
    migaloo = mkApp {
      package = "migaloo";
      program = "${packages.migaloo}/bin/migalood";
    };
    celestia-app = mkApp {
      package = "celestia-app";
      program = "${packages.celestia}/bin/celestia-appd";
    };
    celestia-node = mkApp {
      package = "celestia-node";
      program = "${packages.celestia-node}/bin/celestia";
    };
    provenance = mkApp {
      package = "provenance";
      program = "${packages.provenance}/bin/provenanced";
    };
    dymension = mkApp {
      package = "dymension";
      program = "${packages.dymension}/bin/dymd";
    };
    push-store = mkApp {
      program = "${scripts.push-store}/bin/push-store";
      description = "Push selected flake packages to a binary cache";
    };
  }
  // lib.optionalAttrs pkgs.stdenv.isLinux {
    stargaze = mkApp {
      package = "stargaze";
      program = "${packages.stargaze}/bin/starsd";
    };
    namada = mkApp {
      package = "namada";
      program = "${packages.namada}/bin/namada";
    };
  }
