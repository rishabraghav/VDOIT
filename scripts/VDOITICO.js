// deployVDOITICO.js
async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying VDOITICO contract with the account:", deployer.address);
  
    const VDOITToken = await ethers.getContractFactory("VDOITToken");
    const vdoitToken = await VDOITToken.deploy();
    // await vdoitToken.deployed();
    const VDOITTokenAddress = await vdoitToken.getAddress();
    console.log("VDOITToken deployed to:", VDOITTokenAddress);
  
    const VDOITICO = await ethers.getContractFactory("VDOITICO");
    const vdoitICO = await VDOITICO.deploy(VDOITTokenAddress);
    // await vdoitICO.deployed();
  
    console.log("VDOITICO deployed to:", await vdoitICO.getAddress());
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  