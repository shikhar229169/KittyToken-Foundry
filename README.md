# KittyToken-Foundry
This repo demonstrates about ERC20 token in foundry framework.

## Quickstart
```
git clone https://github.com/shikhar229169/KittyToken-Foundry.git
cd KittyToken-Foundry
forge build
```

# Usage
## Start a Local Node
```
anvil
```

## Deploy on Mumbai Network
```
forge script script/DeployKittyToken.s.sol --rpc-url $MUMBAI_RPC_URL --private-key $PRIVATE_KEY --verify --etherscan-api-key $POLYGONSCAN_API_KEY --broadcast
```

## Deploy on Anvil
```
forge script script/DeployKittyToken.s.sol --rpc-url $RPC_URL --private-key $ANVIL_PRIVATE_KEY --broadcast
```

## Test on anvil
```
forge test
```

## Test on fork mumbai network
```
forge test --fork-url $MUMBAI_RPC_URL
```

## Test Coverage
```
forge coverage
```
