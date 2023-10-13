require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
require('dotenv').config();
const { API_URL, PRIVATE_KEY } = process.env;

module.exports = {
  solidity: "0.8.20",
  paths: {
    sources: "./contracts",
    artifacts: "./artifacts",
  },
  networks: {
    polygon: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/F62NiqIR_9bFHod2gOcm-8RKQrpyArlz",
      accounts: ["7bd9db115517973562d180af6ad13db072f1dd788a55f49f3e3fec80a7d2b7f5"],
    },
  },
};