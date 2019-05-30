const { providers, Contract, Wallet, utils } = require('ethers')

const { RelayerRegistration } = require('../src/utils/abis')

require('dotenv').config()

let provider = new providers.JsonRpcProvider(process.env.RPC_URL)

let privateKey = process.env.REGISTER_PRIVATE_KEY
let wallet = new Wallet(privateKey, provider)

let relayerRegistrationContractAddress = process.env.RELAYER_REGISTRATION_CONTRACT_ADDRESS

const relayerRegistrationContract = new Contract(
  relayerRegistrationContractAddress,
  RelayerRegistration,
  wallet,
)

relayerRegistrationContract.on('RegisterEvent', (author, oldValue, newValue, event) => {
  console.log('SUCCESS')
  console.log(event)
  console.log(oldValue)
  console.log(newValue)
})

const payload = {
  coinbase: process.env.COINBASE_ADDRESS,
  makerFee: 1,
  takerFee: 1,
  from: [
    '0x26112598A16b3Ab67d8e5032F2B54bb3007D3631',
    '0x48a6f998ADF65E9f553d14e117Bf4EaD61425940',
  ],
  to: [
    '0x760DC56151079fE87Ac72aDA3dBBA1E5D8c3bd32',
    '0x21b8B4A00C7Fed77ecB45b3662E0Fa46EEd793d6',
  ],
}

const overrides = {
  gasLimit: 1000000,
  value: utils.parseEther('25000'),
}

const registerRelayer = async () => {
  try {

    const tx = await relayerRegistrationContract.register(
      payload.coinbase,
      payload.makerFee,
      payload.takerFee,
      payload.from,
      payload.to,
      overrides,
    )

    console.log(tx.hash)

    await tx.wait()

  } catch (err) {
    console.log(err)
  }
}

registerRelayer()
