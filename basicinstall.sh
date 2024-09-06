#!/bin/bash

# Clone the repository
git clone https://github.com/allora-network/basic-coin-prediction-node
cd basic-coin-prediction-node || exit

# Copy the .env.example to .env
cp .env.example .env

# Function to update .env file with user input
update_env() {
  key=$1
  value=$2
  sed -i "s/^$key=.*/$key=$value/" .env
}

# Prompt user for the necessary input
echo "Please select a TOKEN from the list below:"
PS3="Enter your choice (1-5): "
options=("ETH" "SOL" "BTC" "BNB" "ARB")
select opt in "${options[@]}"; do
  if [[ -n $opt ]]; then
    update_env "TOKEN" "$opt"
    break
  fi
done

# Prompt for TRAINING_DAYS
read -p "Enter the number of TRAINING_DAYS (e.g., 2, 31): " training_days
update_env "TRAINING_DAYS" "$training_days"

# Prompt for TIMEFRAME based on the training days
echo "Please select a TIMEFRAME based on TRAINING_DAYS:"
if [[ $training_days -le 2 ]]; then
  echo "Use a TIMEFRAME of >= 30min"
elif [[ $training_days -le 30 ]]; then
  echo "Use a TIMEFRAME of >= 4h"
else
  echo "Use a TIMEFRAME of >= 4d"
fi
read -p "Enter the TIMEFRAME (e.g., 30min, 4h, 4d): " timeframe
update_env "TIMEFRAME" "$timeframe"

# Prompt for MODEL
echo "Please select a MODEL:"
PS3="Enter your choice (1-4): "
models=("LinearRegression" "SVR" "KernelRidge" "BayesianRidge")
select model in "${models[@]}"; do
  if [[ -n $model ]]; then
    update_env "MODEL" "$model"
    break
  fi
done

# Prompt for REGION
echo "Please select a REGION:"
PS3="Enter your choice (1-2): "
regions=("EU" "US")
select region in "${regions[@]}"; do
  if [[ -n $region ]]; then
    update_env "REGION" "$region"
    break
  fi
done

# Prompt for DATA_PROVIDER
echo "Please select a DATA_PROVIDER:"
PS3="Enter your choice (1-2): "
providers=("Binance" "Coingecko")
select provider in "${providers[@]}"; do
  if [[ -n $provider ]]; then
    update_env "DATA_PROVIDER" "$provider"
    break
  fi
done

# Prompt for CG_API_KEY if Coingecko is selected
if [[ $provider == "Coingecko" ]]; then
  read -p "Enter your Coingecko API Key: " cg_api_key
  update_env "CG_API_KEY" "$cg_api_key"
else
  update_env "CG_API_KEY" ""
fi

# Copy config.example.json to config.json
cp config.example.json config.json

# Prompt for wallet name and seed phrase
read -p "Enter your wallet name: " wallet_name
read -p "Enter your seed phrase: " seed_phrase

# Function to update config.json file with user input
update_config() {
  key=$1
  value=$2
  sed -i "s/\"$key\": \".*\"/\"$key\": \"$value\"/" config.json
}

# Update config.json with wallet name and seed phrase
update_config "addressKeyName" "$wallet_name"
update_config "addressRestoreMnemonic" "$seed_phrase"

# Make init.config executable and run it
chmod +x init.config
./init.config

# Start Docker containers and build
docker compose up --build -d

# Output completion message - Installation Complete
echo "Your .env and config.json files have been updated with your choices!"
echo "Docker containers have been started. To check logs, run:"
echo "docker compose -logs worker"
