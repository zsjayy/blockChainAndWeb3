const { ether } = require("hardhat")

async function main() {
    //await是与async搭配使用
    const mytokenFactory = await ethers.getContractFactory("MyToken")
    console.log("Deploying MyToken...")
    //这里只是发送deploy的操作
    const mytoken = await mytokenFactory.deploy()
    await mytoken.waitForDeployment()
    console.log("MyToken deployed to successfully,address is:", mytoken.address);
}

main().then().catch((erroe) => {
    console.error(error)
    process.exit(1)
})