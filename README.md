### Features:
- A fixed owner of a vault can deposit eth to it until the vault lasts
- no eth can be withdrawn from the vault until a fixed time in the future
- every deposit is recorded and every withdrawal will be recorded
- there will be a call each time there is a withdrawal attempt during lock period.
- can get total eth in vault, see time remaining until the vault unlocks
- owner can extend the lock period of the vault
- only 10% of total vault balance can be withdrawn at once and only one withdrawal can be made in a 1 hour time span
- each withdrawal will be recorded
- the owner can destroy the vault transferring the entire balance of the contract to a backup account in case they lose their private key





## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
