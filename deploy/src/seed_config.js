require('dotenv').config()
const faker = require('faker')
const MongoClient = require('mongodb').MongoClient
const Long = require('mongodb').Long

const { DB_NAME, mongoUrl } = require('./config/config')
const { getEthereumBlockNumber } = require('./utils/helpers')

const networkID = process.env.NETWORK_ID

if (!networkID) {
  console.log('Please update .env file')
  return
}

const create = async () => {
  const ethereumBlockNumber = await getEthereumBlockNumber(networkID)
  const client = await MongoClient.connect(
    mongoUrl,
    { useNewUrlParser: true },
  )

  const db = client.db(DB_NAME)
  await db.createCollection('config')

  const index = await db
    .collection('config')
    .createIndex({ key: 1 }, { unique: true })

  const createdAt = new Date(faker.fake('{{date.recent}}'))
  const documents = [
    { key: 'schema_version', value: Long.fromInt(2), createdAt },
    { key: 'ethereum_last_block', value: Long.fromInt(ethereumBlockNumber), createdAt },
    { key: 'ethereum_address_index', value: Long.fromInt(0), createdAt },
  ]
  console.log(documents)
  try {
    await db.collection('config').insertMany(documents)
  } catch (e) {
    console.log(e)
  } finally {
    client.close()
  }
}

create()
