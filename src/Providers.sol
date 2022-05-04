//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Providers {
    struct Provider {
        bytes pubkey; // 64 byte public key
        bytes32 netAddr; // 32 byte network address
    }

    mapping(address => Provider) public Oracles;

    event ProviderJoin(Provider p);
    event ProviderExit(Provider p);

    // Join the provider network
    function join(bytes memory pubkey, bytes32 netAddr) public {
        Provider memory p = Provider(pubkey, netAddr);
        Oracles[msg.sender] = p;
        emit ProviderJoin(p);
    }

    // Exit the provider network
    function exit() public {
        Provider memory p = Oracles[msg.sender];
        if (p.netAddr != 0) {
            delete Oracles[msg.sender];
            emit ProviderExit(p);
        }
    }
}
