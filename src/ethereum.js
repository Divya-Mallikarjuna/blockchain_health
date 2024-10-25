import Web3 from "web3";
import HealthcareInsurance from "./contracts/HealthcareInsurance.json"; // Ensure this path is correct

const initWeb3 = async () => {
  try {
    const web3 = new Web3(Web3.givenProvider || "http://localhost:8545");
    const networkId = await web3.eth.net.getId();
    const deployedNetwork = HealthcareInsurance.networks[networkId];

    if (!deployedNetwork) {
      throw new Error("Contract not deployed on this network");
    }

    const contract = new web3.eth.Contract(
      HealthcareInsurance.abi,
      deployedNetwork && deployedNetwork.address
    );
    return contract;
  } catch (error) {
    console.error("Failed to initialize web3 or load contract:", error);
  }
};

export default initWeb3;
