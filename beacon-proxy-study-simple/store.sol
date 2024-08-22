// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./beacon.sol";

contract Store {
    uint public number = 10;

    address beaconAddress;

    constructor(uint _number, address _beaconAddress) {
        number = _number;
        beaconAddress = _beaconAddress;
    }

    function calc(uint _number0, uint _number1) public {
        address implementAddress = Beacon(beaconAddress).implementation();
        (bool success, ) = implementAddress.delegatecall(abi.encodeWithSignature("calc(uint256,uint256)", _number0, _number1));
        require(success, "failed");
    }

    function destroy() private {
        selfdestruct(payable(address(this)));
    }
}