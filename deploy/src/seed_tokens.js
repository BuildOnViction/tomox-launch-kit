require('dotenv').config()
const utils = require('ethers').utils
const faker = require('faker')
const MongoClient = require('mongodb').MongoClient

const { DB_NAME, mongoUrl, nativeCurrency, relayerDataJSON } = require('./config/config')

let documents = []
let tokens = relayerDataJSON.tokens
let client, db
let hasTomo = false

const seed = async () => {
  try {
    client = await MongoClient.connect(
      mongoUrl,
      { useNewUrlParser: true },
    )
    console.log('Seeding tokens collection')
    db = client.db(DB_NAME)

    for (const t in tokens) {
      if (tokens[t].symbol === "TOMO") {
        hasTomo = true
        break
      }
    }

    documents = Object.keys(tokens).map(address => {
      if (tokens[address].symbol === "TOMO" && hasTomo) {
        return {
          symbol: tokens[address].symbol,
          contractAddress: utils.getAddress(nativeCurrency.address),
          decimals: tokens[address].decimals,
          makeFee: tokens[address].makeFee,
          takeFee: tokens[address].takeFee,
          quote: false,
          createdAt: new Date(faker.fake('{{date.recent}}')),
        }
      } else {
        return {
          symbol: tokens[address].symbol,
          contractAddress: utils.getAddress(address),
          decimals: tokens[address].decimals,
          makeFee: tokens[address].makeFee,
          takeFee: tokens[address].takeFee,
          quote: false,
          createdAt: new Date(faker.fake('{{date.recent}}')),
        }
      }
    })

    if (!hasTomo) {
      // Add TOMO symbol
      documents.push({
        symbol: nativeCurrency.symbol,
        contractAddress: utils.getAddress(nativeCurrency.address),
        decimals: nativeCurrency.decimals,
        makeFee: nativeCurrency.makeFee.toString(),
        takeFee: nativeCurrency.takeFee.toString(),
        quote: false,
        createdAt: new Date(faker.fake('{{date.recent}}')),
      })
    }

    if (documents && documents.length > 0) {
      await db.collection('tokens').insertMany(documents)
    }
    client.close()
  } catch (e) {
    throw new Error(e.message)
  } finally {
    client.close()
  }
}

seed()
