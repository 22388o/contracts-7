## Solidity Smart Contracts for the Georacle Network

[![CircleCI](https://circleci.com/gh/georacle-labs/go-osm/tree/main.svg?style=shield)](https://circleci.com/gh/georacle-labs/contracts/tree/main)

## Installation

```sh
# via Yarn
$ yarn add @georacle/contracts

# via npm
$ npm i -S @georacle/contracts
```

### Usage

The Solidity smart contracts can be imported via the `src` directory of `@georacle/contracts`

```solidity
import '@georacle/contracts/src/.sol';
```

## Local Development with [Hardhat](https://hardhat.org/)

1. Clone this repo

```sh
    $ git clone https://github.com/georacle-labs/contracts.git && cd contracts
```

2. Populate the environment file

```sh
    # Update environment variables
    $ mv .env.example .env
```

## Testing

1. Deploy Contracts

```sh
    $ npx hardhat deploy --network rinkeby
```

2. Continue with Hardhat

```sh
    $ npx hardhat test --network rinkeby
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/georacle-labs/contracts

## License

The package is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT)
