const path = require("path");

require('dotenv').config()

const HDWalletProvider = require('@truffle/hdwallet-provider');

const mnemonic = process.env.MNEMONIC
const clientURL = process.env.ETH_CLIENT_URL

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, "client/src/contracts"),
  networks: {
    // develop: {
    //   host: "127.0.0.1",
    //   port: 7545,
    //   network_id: "*"
    // },
    ropsten: {
      provider: () => new HDWalletProvider(mnemonic, `https://ropsten.infura.io/v3/8d3e8e448e3f420bb6f184a58539675e`),
      network_id: 3,       // Ropsten's id
      gas: 5500000,        // Ropsten has a lower block limit than mainnet
      confirmations: 2,    // # of confs to wait between deployments. (default: 0)
      // timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
      },
  },
  compilers: {
    solc: {
      version: ">=0.4.21 <0.9.0",    // Fetch exact version from solc-bin (default: truffle's version)
    }
  }
};
