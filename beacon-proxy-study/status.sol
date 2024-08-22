// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./beacon.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC20/ERC20.sol";

contract Status is ERC20 {
    uint public result = 1;
    address public beaconAddress;

    constructor(address _beacon,string memory name, string memory symbol) ERC20(name,symbol) {
        beaconAddress = _beacon;
    }

    function getLogicAddress() public view returns(address) {
        return Beacon(beaconAddress).implementaionAddress();
    }

    function multi(uint a) public returns(bool, uint) {
        address logic = Beacon(beaconAddress).implementaionAddress();
        (bool success, ) = logic.delegatecall(abi.encodeWithSignature("multi(uint256)", a));
        return (success, result);
    }

    function mint(uint amount) public returns(bool, uint256) {
        address logic = Beacon(beaconAddress).implementaionAddress();
        (bool success, ) = logic.delegatecall(abi.encodeWithSignature("mint(uint256)", amount));
        return (success, totalSupply());
    }

    function getToalSupply() public view returns(uint) {
        address logic = Beacon(beaconAddress).implementaionAddress();
        (bool success, ) = logic.staticcall(abi.encodeWithSignature("getToalSupply()"));
    }
}