import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract A {
	constructor(address foo) {
		// do something...
	}
}

//프록시 패턴에서 생성자를 사용할 수 없기 때문에 아래와 같은 방식으로 사용함 
//생성자 함수와 동일한 역할을 수행할 수 있음 
contract B is Initializable {
    // cannot call initialize more than once due to the `initializer` modifier
    function initialize(
        address foo
    ) public initializer {
        // do something same as contract A contructor code
    }
}