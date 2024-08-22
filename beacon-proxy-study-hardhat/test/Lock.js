const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("My Service", async () => {
  let ImplementationV0;
  let ImplementationV1;
  let Beacon;
  let Factory;
  let Store;

  before(async () => {
    ImplementationV0 = await ethers.getContractFactory("Implementation_V0");
    ImplementationV1 = await ethers.getContractFactory("Implementation_V1");
    Beacon = await ethers.getContractFactory("Beacon");
    Factory = await ethers.getContractFactory("Factory");
    Store = await ethers.getContractFactory("Store");
  });

  describe("version 0", () => {
    let implementationV0;

    let factory;
    let beacon;

    let store0;
    let store1;

    before(async () => {
      implementationV0 = await ImplementationV0.deploy();
      beacon = await Beacon.deploy();
      factory = await Factory.deploy();

      await beacon.upgradeImplementation(implementationV0.target);

      const didCreateStoreTx0 = await factory.createStore(1, beacon);
      const didCreateStoreTx1 = await factory.createStore(2, beacon);

      const events = await factory.queryFilter("Deploy");

      store0 = await ethers.getContractAt("Store", events[0].args[0]);
      store1 = await ethers.getContractAt("Store", events[1].args[0]);
    });

    it("beacon version check", async () => {
      const implementationV0Address = await beacon.implementation();
      await expect(implementationV0Address).to.equal(implementationV0.target);
    });

    it("deploy store", async () => {
      const number0 = await store0.number();
      const number1 = await store1.number();

      await expect(number0).to.equal(1n);
      await expect(number1).to.equal(2n);
    });

    it("calc store", async () => {
      const tx0 = await store0.calc(1, 2);
      const tx1 = await store1.calc(10, 20);

      const number0 = await store0.number();
      const number1 = await store1.number();

      await expect(number0).to.equal(3n);
      await expect(number1).to.equal(30n);
    });
  });

  describe("upgrade version 1", () => {
    let implementationV0;

    let factory;
    let beacon;

    let store0;
    let store1;

    before(async () => {
      implementationV0 = await ImplementationV0.deploy();
      implementationV1 = await ImplementationV1.deploy();
      beacon = await Beacon.deploy();
      factory = await Factory.deploy();

      await beacon.upgradeImplementation(implementationV0.target);

      const didCreateStoreTx0 = await factory.createStore(1, beacon);
      const didCreateStoreTx1 = await factory.createStore(2, beacon);

      const events = await factory.queryFilter("Deploy");

      store0 = await ethers.getContractAt("Store", events[0].args[0]);
      store1 = await ethers.getContractAt("Store", events[1].args[0]);

      await beacon.upgradeImplementation(implementationV1.target);
    });

    it("beacon version check", async () => {
      const implementationV1Address = await beacon.implementation();
      await expect(implementationV1Address).to.equal(implementationV1.target);
    });

    it("deploy store", async () => {
      const number0 = await store0.number();
      const number1 = await store1.number();

      await expect(number0).to.equal(1n);
      await expect(number1).to.equal(2n);
    });

    it("calc store", async () => {
      const tx0 = await store0.calc(1, 2);
      const tx1 = await store1.calc(10, 20);

      const number0 = await store0.number();
      const number1 = await store1.number();

      await expect(number0).to.equal(2n);
      await expect(number1).to.equal(200n);
    });
  });
});
