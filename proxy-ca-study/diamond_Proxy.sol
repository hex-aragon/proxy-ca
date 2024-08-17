// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDiamondCut {

    enum FacetAction { Add, Replace, Remove }
    struct FacetCut {
        address facetAddress;
        FacetAction action;
        bytes4[] functionSelectors;
    }

    function diamondCut(FacetCut[] calldata _facetCuts) external;
}

contract DiamondStorage {

    struct FacetAddressAndSelector {
        mapping(bytes4 => address) selectorToFacet;
    }

    function diamondStorage() internal pure returns (FacetAddressAndSelector storage ds) {
        bytes32 position = keccak256("diamond.standard.diamond.storage");
        assembly {
            ds.slot := position
        }
    }
}

contract Diamond is IDiamondCut, DiamondStorage {

    function diamondCut(FacetCut[] calldata _facetCuts) external override {
        FacetAddressAndSelector storage ds = diamondStorage();
        for (uint256 i = 0; i < _facetCuts.length; i++) {
            FacetCut memory _facetCut = _facetCuts[i];
            address _facetAddress = _facetCut.facetAddress;
            for (uint256 j = 0; j < _facetCut.functionSelectors.length; j++) {
                bytes4 selector = _facetCut.functionSelectors[j];
                if (_facetCut.action == FacetAction.Add || _facetCut.action == FacetAction.Replace) {
                    ds.selectorToFacet[selector] = _facetAddress;
                } else if (_facetCut.action == FacetAction.Remove) {
                    ds.selectorToFacet[selector] = address(0);
                }
            }
        }
    }

    fallback() external payable {
        FacetAddressAndSelector storage ds = diamondStorage();
        address facet = ds.selectorToFacet[msg.sig];
        require(facet != address(0), "Function does not exist.");
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), facet, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}