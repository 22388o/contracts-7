const { assert } = require('chai');
const { generateKeyPairSync } = require('crypto');
const { ethers, getNamedAccounts } = require('hardhat');

const hexEncode = (x) => `${x.split('').map((i) => i.charCodeAt(0).toString(16).padStart(2, '0')).join('')}`;

describe('Providers', async () => {
  describe('Provider Join', () => {
    it('Provider join should be valid', async () => {
      const Providers = await ethers.getContract('Providers');
      const { publicKey } = await generateKeyPairSync('ed25519');

      const pub = `0x${publicKey.export({ type: 'spki', format: 'der' }).toString('hex')}`;
      const netAddr = `0x${hexEncode('0.0.0.0:9000').padEnd(64, '0')}`;

      const providerJoinTx = await Providers.join(pub, netAddr);
      await providerJoinTx.wait();

      const { deployer } = await getNamedAccounts();
      const provider = await Providers.Oracles(deployer);

      assert(provider.pubkey === pub && provider.netAddr === netAddr);
    });
  });
});
