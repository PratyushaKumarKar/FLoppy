const { ethers } = require('ethers');
const { MaticPOSClient } = require('@maticnetwork/maticjs');

async function deployContract() {
  const maticProviderUrl = 'https://rpc-mumbai.maticvigil.com/'; // Replace with the Matic provider URL
  const parentProviderUrl = 'https://eth.llamarpc.com'; // Replace with the Ethereum Mainnet provider URL
  const privateKey = '0773de639170dcb7713df416a934c4ef0b4462b42d661554fb4d2c0ead67a55b'; // Replace with your private key

  const provider = new ethers.providers.JsonRpcProvider(maticProviderUrl);
  const wallet = new ethers.Wallet(privateKey, provider);

  const maticPOSClient = new MaticPOSClient({
    network: 'testnet', // Replace with the network (testnet or mainnet) you want to use
    version: 'mumbai', // Replace with the version of the network you want to use (e.g., mumbai, matic)
    parentProvider: new ethers.providers.JsonRpcProvider(parentProviderUrl),
    maticProvider: provider,
    parentDefaultOptions: { from: wallet.address },
    maticDefaultOptions: { from: wallet.address },
  });

  const contractFactory = await ethers.getContractFactory('YourSmartContract');
  const contract = await contractFactory.connect(wallet).deploy();

  await contract.deployed();

  console.log('Contract deployed at address:', contract.address);
}

deployContract().catch(console.error);
