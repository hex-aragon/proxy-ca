// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Implementation_V1 {
    uint public number = 10;

    function calc(uint _number0, uint _number1) public {
        number = _number0 * _number1;
    }
}