// Beacon contract - 프록시와 원본 컨트랙트 간의 상호작용을 관리
contract Beacon {
    address public implementation;

    // 프록시의 로직 컨트랙트를 설정하는 함수
    function setImplementation(address _implementation) external {
        implementation = _implementation;
    }
}

// Logic contract - 실제 로직을 포함하는 스마트 컨트랙트
contract LogicContract {
    uint256 public data;

    // 상태를 변경하는 함수
    function setData(uint256 _data) external {
        data = _data;
    }

    // 상태를 조회하는 함수
    function getData() external view returns (uint256) {
        return data;
    }
}

// Logic contract - 실제 로직을 포함하는 스마트 컨트랙트
contract LogicContract2 {
    uint256 public data;

    // 상태를 변경하는 함수
    function setData(uint256 _data) external {
        data = _data;
    }

    // 상태를 조회하는 함수
    function getData() external view returns (uint256) {
        return data;
    }

    function up() public {
        data++;
    }
}

// BeaconProxy contract - 사용자와 프록시 사이의 인터페이스 역할
contract BeaconProxy {
    address public beacon;
    mapping(uint256 => address) private datas;

    constructor(address _beacon) {
        beacon = _beacon;
    }

    fallback() external {
        address _impl = Beacon(beacon).implementation();
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let success := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
            let retSz := returndatasize()
            returndatacopy(ptr, 0, retSz)
            switch success
            case 0 {
                revert(ptr, retSz)
            }
            default {
                return(ptr, retSz)
            }
        }
        
        
    }

    function getImplementation() public view returns (address) {
        return Beacon(beacon).implementation();
    }

    function getData(uint256 x) public view returns (address) {
        return datas[x];
    }
}

