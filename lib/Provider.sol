//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Provider {
    struct Node {
        bytes pubkey; // 64 byte public key
        bytes32 netAddr; // 32 byte network address
    }
}
