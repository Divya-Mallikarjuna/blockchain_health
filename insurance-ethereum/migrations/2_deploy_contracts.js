const HealthcareInsurance = artifacts.require("HealthcareInsurance");

module.exports = function(deployer) {
  deployer.deploy(HealthcareInsurance);
};
