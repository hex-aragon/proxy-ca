// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./status.sol";

contract Factory {
    function createStatus(address _beaconAddress, string memory name, string memory symbol) public returns(address) {
        Status status = new Status(_beaconAddress, name, symbol);
        return address(status);
    }

    function createStatusV2(address _beaconAddress) public returns(address) {
        address addr;
        bytes memory bytecode = abi.encodePacked(
            type(Status).creationCode,
            abi.encode(_beaconAddress)
        );

        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode), 0)
            if iszero(extcodesize(addr)) {
                revert(0,0)
            }
        }

        return addr;
    }
}