const ethers = require('ethers')
const { utils } = require('ethers')

const getEthereumBlockNumber = async networkID => {
  let httpProvider

  // Get latest block number
  switch (networkID) {
    case '8888':
      httpProvider = ethers.getDefaultProvider('ropsten')
      break
    case '89':
      httpProvider = ethers.getDefaultProvider('ropsten')
      break
    case '88':
      httpProvider = ethers.getDefaultProvider('homestead')
      break
    default:
      httpProvider = ethers.getDefaultProvider('ropsten')
      break
  }

  return await httpProvider.getBlockNumber()
}

const getPriceMultiplier = (baseTokenDecimals, quoteTokenDecimals) => {
  let defaultPricepointMultiplier = utils.bigNumberify(1e9)
  let decimalsPricepointMultiplier = utils.bigNumberify(
    (10 ** (Math.abs(baseTokenDecimals - quoteTokenDecimals))).toString(),
  )

  return defaultPricepointMultiplier.mul(decimalsPricepointMultiplier)
}

module.exports = {
  getEthereumBlockNumber,
  getPriceMultiplier,
}
