require("@nomiclabs/hardhat-waffle");

module.exports = {
  networks: {
    hardhat: {},
    localtestnet: {
      url: "http://localhost:8545", // Replace with the desired RPC URL for your local testnet
    },
  },
  solidity: {
    version: "0.8.4",
  },
};
