// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC20/ERC20.sol";

contract implementation_V5 is ERC20 {
    uint public result = 10;
    
    constructor(string memory name, string memory symbol) ERC20(name,symbol) {
    }

    function multi(uint a) public returns(bool, uint) {
        result = a * 5;
        return (true, a * 5);
    }
        function mint(uint amount) public returns(uint256) {
        _mint(msg.sender, amount*5);
        return totalSupply();
    }
}