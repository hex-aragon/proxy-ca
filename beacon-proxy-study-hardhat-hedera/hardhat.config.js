require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  // Specifies which network configuration will be used by default when you run Hardhat commands.
  defaultNetwork: "local",
  networks: {
    // Defines the configuration settings for connecting to Hedera local node
    local: {
      // Specifies URL endpoint for Hedera local node pulled from the .env file
      url: process.env.LOCAL_NODE_ENDPOINT,
      // Your local node operator private key pulled from the .env file
      accounts: [process.env.LOCAL_NODE_OPERATOR_PRIVATE_KEY],
    },
  },
};
