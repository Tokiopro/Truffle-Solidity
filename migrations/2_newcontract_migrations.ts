const SimpleBank = artifacts.require("SimpleBank");

module.exports = function (deployer: any) {
    deployer.deploy(SimpleBank);
};