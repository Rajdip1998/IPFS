const Web3 = require('web3');
const web3 = new Web3('http://localhost:8545'); // Replace with your Besu node URL

const accountAddress = '0xYourAccountAddress'; // Replace with your account address
const privateKey = '0xYourPrivateKey'; // Replace with your account's private key

const { contractBytecode, contractABI } = require('./compiledContract'); // Replace with the correct path

const MyContract = new web3.eth.Contract(contractABI);

const deployOptions = {
  data: '0x' + contractBytecode,
  gas: 2000000, // Adjust the gas limit as needed
};

// Create a transaction object
const transactionObject = MyContract.deploy(deployOptions);

// Estimate the gas needed for the transaction
web3.eth.estimateGas({
  from: accountAddress,
  data: transactionObject.encodeABI(),
}).then((gasAmount) => {
  // Create the raw transaction
  const rawTransaction = {
    nonce: web3.utils.toHex(web3.eth.getTransactionCount(accountAddress)),
    gasPrice: web3.utils.toHex(web3.utils.toWei('20', 'gwei')), // Adjust the gas price as needed
    gasLimit: web3.utils.toHex(gasAmount),
    to: null,
    data: transactionObject.encodeABI(),
  };

  // Sign the raw transaction
  const signedTransaction = web3.eth.accounts.signTransaction(rawTransaction, privateKey);

  // Send the raw transaction
  web3.eth.sendSignedTransaction(signedTransaction.rawTransaction)
    .on('receipt', (receipt) => {
      console.log('Contract deployed at address:', receipt.contractAddress);
    })
    .catch((error) => {
      console.error('Error deploying contract:', error);
    });
});
