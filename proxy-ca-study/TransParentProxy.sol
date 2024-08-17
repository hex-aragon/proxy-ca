// 솔리디티에서 함수 식별자는 함수 시그니처(signature)를 해싱하여 앞의 4바이트만 사용하게 된다. 4바이트가 그렇게 큰 값은 아니기 때문에, 함수명과 파라미터등이 다른 경우에도 얼마든지 충돌이 발생할 수 있다. 그래서 솔리디티 컴파일러는 같은 컨트랙트 내에서 시그니처가 다른데도 불구하고 식별자가 겹치는 경우를 미리 방지한다. 하지만, 프록시와 로직 컨트랙트는 구분된 ‘다른’ 컨트랙트이다. 따라서 컴파일 단계에서 이러한 이슈를 미리 방지할 수 없다.

// 이런 이슈를 해결하기 위해 나온것이 바로 다음에 살펴볼 Transparent 패턴이다.

// Transparent
// Transparent 프록시 패턴의 핵심은 두가지이다.

// 1.사용자 어카운트와 어드민 어카운트의 함수 호출 대상 컨트랙트를 구분하는 것
// 2.업그레이드 관련 로직을 프록시 컨트랙트에 구현하는 것

//1번을 통해 위의 함수 충돌 이슈를 해결하게 된다. 유저 어카운트는 항상 로직 컨트랙트의 함수를 실행하도록 하고, 
//프록시 컨트랙트 오너는 항상 프록시 컨트랙트의 함수를 실행하도록 한다. 이를 통해 함수 충돌 이슈는 발생하지 않게 된다. 
//또한, 2번을 통해 프록시 컨트랙트의 오너가 항상 업그레이드를 문제 없이 수행할 수 있도록 보장한다.

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (utils/StorageSlot.sol)
// This file was procedurally generated from scripts/generate/templates/StorageSlot.js.

pragma solidity ^0.8.24;

contract TransparentProxy {
    function _delegate(address implementation) internal virtual { /*..*/ }
		function implementation() external ifAdmin returns (address implementation_) {
        implementation_ = _implementation();
    }
    fallback() external { /*..*/ } // call _delegate()
		function upgradeTo(address newImplementation) external ifAdmin {
		// check if caller is admin
		// upgrade to newImplementation
		}
		// Makes sure the admin cannot access the fallback function
    function _beforeFallback() internal virtual override {
        require(msg.sender != _getAdmin(), "TransparentUpgradeableProxy: admin cannot fallback to proxy target");
        super._beforeFallback();
    }
}

//fallback 함수 호출마다 msg.sender가  admin 어카운트인지 아닌지 확인해야함 
//>> 돈이새는 것처럼 보임, 보안과 가스 측면에서 불필요한 기능
//하드포크 2번 겪으면서 이 패턴은 비효율적인것으로 판명됨 