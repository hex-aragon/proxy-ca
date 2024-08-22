// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Beacon {
    address public implementaionAddress;

    function upgradeLogic(address _logic) public {
        implementaionAddress = _logic;
    }
}