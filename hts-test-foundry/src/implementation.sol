// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Implementation_V0 {
    uint public number = 10;

    function calc(uint _number0, uint _number1) public {
        number = _number0 + _number1;
    }
}