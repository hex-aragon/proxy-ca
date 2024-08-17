// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract DataLocations {
// 레퍼런스 타입 변수들을 블록체인에 직접 저장하고, 값을 업데이트 하고 싶으면 storage 를 사용하자.
// 그냥 읽기만 필요하거나, 블록체인에 상태를 업데이트 할 필요는 없지만, 수정이 필요하다면 memory 를 사용하자.
// 함수 파라미터로 calldata 키워드를 사용하면 가스를 아낄 수 있다. 따라서, 특별한 이유가 있는게 아니라면 calldata를 쓰자.

    uint public x;
    uint public arr;

    struct MyStruct {
        uint foo;
        string text; 
    }

    mapping(address => MyStruct) public myStructs;

    function set(address _addr, string calldata _text) external {
        MyStruct storage myStruct = myStructs[_addr];
        myStruct.text = _text; 
    }

    function get(address _addr) external view returns (string memory) {
        return myStructs[_addr].text;
    }
}

