// SPDX-License-Identifier: MIT


pragma solidity ^0.8.20;

contract FunctionSelector {
    //하단 함수에서 transfer 함수의 반환값과 0xa9059cb 이 값이 같아야함
    //테스트 입력값 = "transfer(address,uint256)" 
    //테스트 출력값 =  0:bytes4: 0xa9059cbb
    function getSelector(string calldata _func ) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}

contract Receiver {
    //트랜스퍼 함수 호출시 로깅 이벤트 정의 
    event Log(bytes data);

    function transfer(address _to, uint _amount) external {
        //이벤트 발생 
        emit Log(msg.data);
        //컨트랙트 배포 후 logs 파트에서 args 인자 중 "data" 영역 
        
        //스마트 컨트랙트에서 데이터를 인코딩해서 호출하는 방식 
        //컨트랙트에서 처음 4바이트 데이터는 호출할 함수를 인코딩한 데이터 
        //0xa9059cb >> evm이 이것을 어떻게 계산하나??
        //evm이 가져오는 방법은 
        //1. 함수 서명의 문자열을 가져온다.
        //2. 해시를 가져온 다음 해시의 처음 4바이트를 가져온다. 그래서 해당 데이터를 evm으로 만든다.
        //before >> function transfer(address _to, uint _amount) external { 
        //after  >> 0xa9059cb

        
        //하단 데이터는 함수에 전달되는 인자 값, 매개변수 값을 인코딩한 것으로 생각하면 된다.
        //b0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
        //000000000000000000000000000000000000000000000000000000000000000b

    }
}