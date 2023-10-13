async function main() {
  const [deployer] = await ethers.getSigners();

  console.log(`deploying contracts with the account ${deployer.address}`);
  const VDOITToken = await ethers.getContractFactory("VDOITToken");
  const vdoitToken = await VDOITToken.deploy();

  const address = vdoitToken.address;
  console.log(`VDOITToken contract is deployed to this address ${address}`);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
