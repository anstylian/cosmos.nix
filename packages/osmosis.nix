{
  cosmosLib,
  osmosis-src,
  libwasmvm_3_0_4,
  libiconv,
}:
cosmosLib.mkCosmosGoApp {
  name = "osmosis";
  version = "v31.0.2";
  goVersion = "1.25";
  src = osmosis-src;
  rev = "697b89f2790dbedba88c1a28396571701ced17ad"; # Revision for v30.0.1
  vendorHash = "sha256-jXfYYZUjm7QU6rCy/zQPUkb3BfgZ1/VA/gUL+n8Cb20=";
  tags = ["netgo"];
  excludedPackages = ["cl-genesis-positions"];
  engine = "cometbft/cometbft";
  preFixup = ''
    ${cosmosLib.wasmdPreFixupPhase libwasmvm_3_0_4 "osmosisd"}
    ${cosmosLib.wasmdPreFixupPhase libwasmvm_3_0_4 "chain"}
    ${cosmosLib.wasmdPreFixupPhase libwasmvm_3_0_4 "node"}
  '';
  buildInputs = [
    libwasmvm_3_0_4
    libiconv
  ];
  proxyVendor = true;

  # Test has to be skipped as end-to-end testing requires network access
  doCheck = false;

  meta = {
    mainProgram = "osmosisd";
  };
}
