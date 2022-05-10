//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Provider.sol";

library UnorderedSet {
    using Provider for Provider.Node;

    struct Element {
        uint256 index;
        Provider.Node element;
    }

    struct Set {
        mapping(address => Element) elements;
        address[] keys;
    }

    /* @notice Add a unique element into the set
     * @param s the unordered set
     * @param a the address to be inserted (key)
     * @param pubkey the public key to be inserted (val)
     * @param netAddr the associated network address (val)
     */
    function add(
        Set storage s,
        address a,
        bytes memory pubkey,
        bytes32 netAddr
    ) internal {
        // revert on duplicate insert
        require(s.elements[a].element.pubkey.length == 0, "Duplicate element");

        // insert new element
        s.elements[a] = Element(s.keys.length, Provider.Node(pubkey, netAddr));
        s.keys.push(a);
    }

    /* @notice Remove an element from the set
     * @param s the unordered set
     * @param a the address to remove
     */
    function remove(Set storage s, address a) internal {
        Element memory e = s.elements[a];

        // revert on nonexistent element
        require(
            e.element.pubkey.length != 0 && e.index < s.keys.length,
            "Nonexistent element"
        );

        swap(s, e.index, s.keys.length - 1);
        s.keys.pop();
        delete s.elements[a];
    }

    /* @notice Swap two elements by index
     * @param s the unordered set
     * @param i the first index
     * @param j the second index
     */
    function swap(
        Set storage s,
        uint256 i,
        uint256 j
    ) internal {
        // revert on an invalid index
        require(i < s.keys.length && j < s.keys.length, "Invalid index");

        // swap keys
        address temp_addr = s.keys[i];
        s.keys[i] = s.keys[j];
        s.keys[j] = temp_addr;

        // swap index
        s.elements[s.keys[i]].index = j;
        s.elements[s.keys[j]].index = i;
    }

    /* @notice Return the list of keys in use
     * @param s the unordered set
     * @return result a list of address (keys)
     */
    function getKeys(Set storage s) internal view returns (address[] storage) {
        return s.keys;
    }

    /* @notice Lookup a provider by address
     * @param s the unordered set
     * @param a the address to lookup
     * @return the associated provider (if exists)
     */
    function getProvider(Set storage s, address a)
        internal
        view
        returns (Provider.Node storage)
    {
        return s.elements[a].element;
    }

    /* @notice Return the length of the set
     * @param s the unordered set
     * @return the number of elements in the set
     */
    function len(Set storage s) internal view returns (uint256) {
        return s.keys.length;
    }
}
