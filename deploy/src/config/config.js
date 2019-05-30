require('dotenv').config()
const fs = require('fs')
const path = require('path')

const dbName = process.env.DB_NAME
const mongoUrl = process.env.MONGODB_URL

if (!dbName || !mongoUrl) {
  console.log('Please update .env file')
  return
}

// __dirname is running folder, __filename is current included file
const relayerData = fs.readFileSync(path.resolve(__dirname, './addresses.json')).toString()

const relayerDataJSON = JSON.parse(relayerData)

const nativeCurrency = {
  symbol: 'TOMO',
  address: '0x0000000000000000000000000000000000000001',
  decimals: 18,
  makeFee: 1,
  takeFee: 1,
}

module.exports = {
  DB_NAME: dbName,
  walletKeys: [
    '0x7f4c1bacba63f05827f6d8fc0e22cf68c42005775a7f73abff7d819986bae77c',
    '0x2c52197df32aa00940685ae94aeb4b8b6f4c81e2c5f9d289ec76eb614adb9686',
  ],
  mongoUrl,
  relayerDataJSON,
  nativeCurrency,
}
