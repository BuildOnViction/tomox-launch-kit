#!/usr/bin/env bash
NETWORK="development"

echo "Query Tokens From dex-smart-contract"
node query_tokens.js $NETWORK

echo "Drop existing collections"
node drop_collection.js --collection pairs --network=$NETWORK
node drop_collection.js --collection tokens --network=$NETWORK
node drop_collection.js --collection orders --network=$NETWORK
node drop_collection.js --collection trades --network=$NETWORK
node drop_collection.js --collection wallets --network=$NETWORK
node drop_collection.js --collection accounts --network=$NETWORK
node drop_collection.js --collection config --network=$NETWORK

echo "Create collections"
node create_accounts_collection.js --network=$NETWORK
node create_orders_collection.js --network=$NETWORK
node create_pairs_collection.js --network=$NETWORK
node create_tokens_collection.js --network=$NETWORK
node create_trades_collection.js --network=$NETWORK
node create_wallets_collection.js --network=$NETWORK
node create_config_collection.js --network=$NETWORK


echo "Seed data"
node seed_tokens.js --network=$NETWORK
node seed_pairs.js --network=$NETWORK
node seed_config.js --network=$NETWORK
node seed_wallets.js --network=$NETWORK
