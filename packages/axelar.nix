{
  cosmosLib,
  axelar-src,
  libwasmvm_1_5_8,
  libiconv,
}: let
  version = "v1.4.0";
  buildTags = "ledger,wasmd";
  denom = "uaxl";
  wasm = "true";
  ibc_wasm_hooks = "false";
  wasm_capabilities = "iterator,staking,stargate,cosmwasm_1_1,cosmwasm_1_2,cosmwasm_1_3";
  max_wasm_size = 3 * 1024 * 1024; # 3 MiB (3 * 1024 * 1024 bytes)
in
  cosmosLib.mkCosmosGoApp {
    name = "axelar";
    inherit version;
    goVersion = "1.25";
    src = axelar-src;
    rev = axelar-src.rev;
    vendorHash = "sha256-Ue302wb5r+98zlIsiuhJe+MwEWPunj5wwvzdL6+zEhE=";
    tags = ["ledger" "wasmd"];
    engine = "tendermint/tendermint";
    trimpath = true;

    ldflags = [
      "-X github.com/cosmos/cosmos-sdk/version.Name=axelar"
      "-X github.com/cosmos/cosmos-sdk/version.AppName=axelard"
      "-X github.com/cosmos/cosmos-sdk/version.Version=${version}"
      "-X github.com/cosmos/cosmos-sdk/version.BuildTags=${buildTags}"
      "-X github.com/cosmos/cosmos-sdk/version.Commit=${axelar-src.rev}"
      "-X github.com/axelarnetwork/axelar-core/x/axelarnet/exported.NativeAsset=${denom}"
      "-X github.com/axelarnetwork/axelar-core/app.WasmEnabled=${wasm}"
      "-X github.com/axelarnetwork/axelar-core/app.IBCWasmHooksEnabled=${ibc_wasm_hooks}"
      "-X github.com/axelarnetwork/axelar-core/app.WasmCapabilities=${wasm_capabilities}"
      "-X github.com/axelarnetwork/axelar-core/app.MaxWasmSize=${
        toString max_wasm_size
      }"
      "-w -s"
    ];

    # -w -s ${STATIC_LINK_FLAGS}
    preFixup = ''
      ${cosmosLib.wasmdPreFixupPhase libwasmvm_1_5_8 "axelard"}
    '';
    buildInputs = [libwasmvm_1_5_8 libiconv];
    proxyVendor = true;
    doCheck = false; # upstream gRPC timeout test is flaky under Nix builds

    meta = {
      mainProgram = "axelard";
      description = "Axelar Core - A Decentralized Blockchain Interoperability Network";
      homepage = "https://github.com/axelarnetwork/axelar-core";
    };
  }
