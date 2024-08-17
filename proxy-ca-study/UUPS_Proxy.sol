contract UUPSLogic {
		function upgradeTo(address newImplementation) external virtual onlyProxy {
        _authorizeUpgrade(newImplementation); // check if admin or not
        _upgradeToAndCallUUPS(newImplementation, new bytes(0), false); // upgrade
    }
}