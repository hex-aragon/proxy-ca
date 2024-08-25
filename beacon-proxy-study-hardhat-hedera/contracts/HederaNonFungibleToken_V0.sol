// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./hedera-system-contracts/HederaTokenService.sol";
import "./hedera-system-contracts/HederaResponseCodes.sol";
import "./hedera-system-contracts/IHederaTokenService.sol";
import "./hedera-system-contracts/ExpiryHelper.sol";
import "./hedera-system-contracts/KeyHelper.sol";

contract HederaNonFungibleToken_V0 is ExpiryHelper, KeyHelper, HederaTokenService {

   uint public number = 10;

  function calc(uint _number0, uint _number1) public {
        number = _number0 + _number1;
  }

  function createNft(
            string memory name, 
            string memory symbol, 
            string memory memo, 
            int64 maxSupply,  
            string memory uri
        ) external payable returns (address){

        IHederaTokenService.TokenKey[] memory keys = new IHederaTokenService.TokenKey[](1);
        // Set this contract as supply for the token
        keys[0] = getSingleKey(KeyType.SUPPLY, KeyValueType.CONTRACT_ID, address(this));

        IHederaTokenService.HederaToken memory token;
        token.name = name;
        token.symbol = symbol;
        token.memo = memo;
        token.treasury = address(this);
        token.tokenSupplyType = true; // set supply to FINITE
        token.maxSupply = maxSupply;
        token.tokenKeys = keys;
        token.freezeDefault = false;
        // token.expiry = createAutoRenewExpiry(address(this), autoRenewPeriod); // Contract auto-renews the token
        token.expiry = createAutoRenewExpiry(address(this), 7_776_000); 

        (int responseCode, address createdToken) = HederaTokenService.createNonFungibleToken(token);

        if(responseCode != HederaResponseCodes.SUCCESS){
            revert("Failed to create non-fungible token");
        }

        int64[] memory serial;
        for (int64 i = 0; i < maxSupply; i++) {
            bytes memory metadata = bytes(uri);
            bytes[] memory metadatas = new bytes[](1);
            metadatas[0] = metadata;
            (responseCode, , serial) = HederaTokenService.mintToken(
                createdToken,
                0,
                metadatas
            );
            if (responseCode != HederaResponseCodes.SUCCESS) {
                revert("failed to mint non-fungible token");
        }
        }

        return createdToken;
    }

    function mintNft(
        address token,
        bytes[] memory metadata
    ) external returns(int64){

        (int response, , int64[] memory serial) = HederaTokenService.mintToken(token, 0, metadata);

        if(response != HederaResponseCodes.SUCCESS){
            revert("Failed to mint non-fungible token");
        }

        return serial[0];
    }

    function transferNft(
        address token,
        address receiver, 
        int64 serial
    ) external returns(int){

        int response = HederaTokenService.transferNFT(token, address(this), receiver, serial);

        if(response != HederaResponseCodes.SUCCESS){
            revert("Failed to transfer non-fungible token");
        }

        return response;
    }
}