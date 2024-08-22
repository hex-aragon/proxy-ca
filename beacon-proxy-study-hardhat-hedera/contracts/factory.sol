// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./store.sol";

contract Factory {
    event Deploy(address addr);

    function createStore(uint n, address _beaconAddress) public returns(address) {
        Store store = new Store(n, _beaconAddress);
        address storeAddress = address(store);
        
        emit Deploy(storeAddress);
        
        return storeAddress;
    }

    function createStoreV2(uint n, address _beaconAddress) public returns(address) {
        address addr;
        bytes32 salt = keccak256(abi.encodePacked(n));
        
        bytes memory bytecode = abi.encodePacked(
            type(Store).creationCode,
            abi.encode(n, _beaconAddress) // 생성자에 전달할 인자. 만약 생성자에 인자를 더 전달해야 한다면 abi.encode(n0, n1, n2) 형태로 호출
        );
        
        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }
        
        emit Deploy(addr);
        
        return addr;
    }
}