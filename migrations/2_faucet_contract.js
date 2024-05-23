const Contract = artifacts.require("faucet");

module.exports = function (deployer) {
    deployer.deploy(Contract);
};