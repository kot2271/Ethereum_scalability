# ETHEREUM_SCALABILITY

## Installation

Clone the repository using the following command:
Install the dependencies using the following command:
```shell
npm i
```

## Deployment

Fill in all the required environment variables(copy .env-example to .env and fill it).
Deploy token contract to the chain (optimisticGoerli, arbitrumGoerli, polygonZkEvmTestnet):

### Optimistic Goerli
[![Optimistic_Goerli](https://img.shields.io/badge/check_the_contract_in_goerli_optimism.etherscan-e32636?style=flat&logo=ethereum)](https://goerli-optimism.etherscan.io/address/0x462cEF234707C9a4Bd9149dF47Df48344773B14F#code)

```shell
npx hardhat run scripts/deploy/deploy.ts --network optimisticGoerli
```

## Verify

Verify the installation by running the following command:
```shell
npx hardhat verify --network optimisticGoerli {CONTRACT_ADDRESS} {CONSTRUCTOR_PARAMETERS}
```

### Arbitrum Goerli

```shell
npx hardhat run scripts/deploy/deploy.ts --network arbitrumGoerli
```

## Verify

Verify the installation by running the following command:
```shell
npx hardhat verify --network arbitrumGoerli {CONTRACT_ADDRESS} {CONSTRUCTOR_PARAMETERS}
```

### Polygon ZkEvm
[![polygonZkEvmTestnet](https://img.shields.io/badge/check_the_contract_in_zkEvmTestnet-9966cc?style=flat&logo=ethereum)](https://testnet-zkevm.polygonscan.com/address/0x462cEF234707C9a4Bd9149dF47Df48344773B14F#code)

```shell
npx hardhat run scripts/deploy/deploy.ts --network polygonZkEvmTestnet
```

## Verify

Verify the installation by running the following command:
```shell
npx hardhat verify --network polygonZkEvmTestnet {CONTRACT_ADDRESS} {CONSTRUCTOR_PARAMETERS}