const { assert, expect } = require('chai');
const { generateKeyPairSync } = require('crypto');
const { ethers, getNamedAccounts } = require('hardhat');

const hexEncode = (x) => `${x.split('').map((i) => i.charCodeAt(0).toString(16).padStart(2, '0')).join('')}`;

describe('Providers', async () => {
  let Providers;
  let pub;
  let netAddr;

  before(async () => {
    Providers = await ethers.getContract('Providers');
    const { publicKey } = await generateKeyPairSync('ed25519');
    pub = `0x${publicKey.export({ type: 'spki', format: 'der' }).toString('hex')}`;
    netAddr = `0x${hexEncode('0.0.0.0:9000').padEnd(64, '0')}`;
  });

  describe('Provider Join', async () => {
    it('Provider join should be valid', async () => {
      const providerJoinTx = await Providers.join(pub, netAddr);
      await providerJoinTx.wait();

      const { deployer } = await getNamedAccounts();

      const provider = await Providers.lookup(deployer);
      assert(provider.pubkey === pub && provider.netAddr === netAddr);

      const providers = await Providers.getProviders();
      assert(providers.length === 1 && providers[0] === deployer);
    });

    it('Subsequent join should revert', async () => {
      await expect(Providers.join(pub, netAddr)).to.be.revertedWith('Duplicate element');
    });
  });

  describe('Provider Exit', async () => {
    it('Provider exit should be valid', async () => {
      const providerExitTx = await Providers.exit();
      await providerExitTx.wait();

      const { deployer } = await getNamedAccounts();

      const provider = await Providers.lookup(deployer);
      assert(provider.pubkey.length - 2 === 0);

      const providers = await Providers.getProviders();
      assert(providers.length === 0);
    });

    it('Subsequent exit should revert', async () => {
      await expect(Providers.exit()).to.be.revertedWith('Nonexistent element');
    });
  });
});
