#!/usr/bin/env bash

echo "Query Tokens From dex-smart-contract"
node scripts/query_tokens.js

echo "Drop existing collections"
node src/drop_collection.js --collection pairs
node src/drop_collection.js --collection tokens
node src/drop_collection.js --collection orders
node src/drop_collection.js --collection trades
node src/drop_collection.js --collection wallets
node src/drop_collection.js --collection accounts
node src/drop_collection.js --collection config

echo "Create collections"
node src/create_accounts_collection.js
node src/create_orders_collection.js
node src/create_pairs_collection.js
node src/create_tokens_collection.js
node src/create_trades_collection.js
node src/create_wallets_collection.js
node src/create_config_collection.js

echo "Seed data"
node src/seed_tokens.js
node src/seed_pairs.js
node src/seed_config.js
node src/seed_wallets.js
