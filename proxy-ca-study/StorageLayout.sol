pragma solidity ^0.8.20;

contract StorageLayout {
	uint256 foo;
	uint256 bar;
	uint256[] items;
	mapping(uint256 => uint256) values;

	function allocate() public {
		require(0 == items.length);
		// allocate array items
		//items.length = 3;
		items[0] = 12;
		items[1] = 42;
		// allocate mapping values
		values[0] = 100;
		values[1] = 200;
	}
}
