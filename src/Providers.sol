//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/UnorderedSet.sol";

contract Providers {
    using UnorderedSet for UnorderedSet.Set;
    UnorderedSet.Set oracles;

    event ProviderJoin(address p);
    event ProviderExit(address p);

    /* @notice Join the provider network
     * @param pubkey the node's public key
     * @param netAddr the associated network address
     */
    function join(bytes memory pubkey, bytes32 netAddr) public {
        oracles.add(msg.sender, pubkey, netAddr);
        emit ProviderJoin(msg.sender);
    }

    /* @notice Exit the provider network
     */
    function exit() public {
        oracles.remove(msg.sender);
        emit ProviderExit(msg.sender);
    }

    /* @notice Lookup a provider by address
     * @return a provider's details (if exists)
     */
    function lookup(address a) public view returns (Provider.Node memory) {
        return oracles.getProvider(a);
    }

    /* @notice Obtain the set of providers currently in the network
     * @return a list of provider addresses
     */
    function getProviders() public view returns (address[] memory) {
        return oracles.getKeys();
    }
}
