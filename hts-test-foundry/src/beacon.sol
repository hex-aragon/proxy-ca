// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Beacon {
    address public implementation;

    function upgradeImplementation(address _implementation) public {
        implementation = _implementation;
    }
}
