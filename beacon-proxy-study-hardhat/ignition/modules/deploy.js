// const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

// module.exports = buildModule("MyServiceModule", (m) => {
//   const implementation_V0 = m.contract("Implementation_V0", []);
//   const beacon = m.contract("Beacon", []);
//   const factory = m.contract("Factory", []);

//   m.call(beacon, "upgradeImplementation", [implementation_V0]);

//   return { implementation_V0, beacon, factory };
// });


const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("MyServiceModule", (m) => {
  const implementation_V0 = m.contract("Implementation_V0", []); // 작업을 수행하지 않음
  const beacon = m.contract("Beacon", []); // 작업을 수행하지 않음
  const factory = m.contract("Factory", []); // 작업을 수행하지 않음

  m.call(beacon, "upgradeImplementation", [implementation_V0] ); // 작업을 수행하지 않음

  
  const implementation_V1 = m.contract("Implementation_V1", []); // 작업이 수행됨
  m.call(beacon, "upgradeImplementation", [implementation_V1], { // 작업이 수행됨
    id: 'upgrade_implementation_v1', // 앞의 m.call과 충동을 방지하기 위해 id 명시(유니크 해야함)
  });

  return { implementation_V0, beacon, factory, implementation_V0 };
});