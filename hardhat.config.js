require('dotenv').config();
require('hardhat-deploy');
require('hardhat-deploy-ethers');

const {
  ETH_URL,
  RINKEBY_URL,
  PRIVATE_KEY,
} = process.env;

module.exports = {
  defaultNetwork: 'localhost',
  networks: {
    mainnet: {
      url: ETH_URL,
      accounts: [`${PRIVATE_KEY}`],
      saveDeployments: true,
    },
    rinkeby: {
      url: RINKEBY_URL,
      accounts: [`${PRIVATE_KEY}`],
      saveDeployments: true,
    },
  },
  solidity: {
    compilers: [
      {
        version: '0.8.4',
      },
    ],
    optimizer: {
      enabled: true,
      runs: 800,
    },
  },
  namedAccounts: {
    deployer: 0,
  },
  paths: {
    sources: 'src',
  },
  mocha: {
    timeout: 600000,
  },
};
