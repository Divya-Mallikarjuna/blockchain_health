// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthcareInsurance {
    
    struct Patient {
        string patientID;
        string insurancePolicy;
        string insuranceCompany;
        uint256 balance; // Amount owed by the patient
    }

    struct InsurancePolicy {
        string policyID;
        string companyName;
        uint256 coverage;  // Total coverage amount
        uint256 deductible;  // Deductible amount
    }

    struct InsuranceCompany {
        string name;
    }

    // Mappings to store data
    mapping(string => Patient) public patients;
    mapping(string => InsurancePolicy) public policies;
    mapping(string => InsuranceCompany) public companies;

    // Events for logging actions
    event PatientAdded(string patientID);
    event InsurancePolicyAdded(string policyID);
    event InsuranceCompanyAdded(string companyName);
    event BillCleared(string patientID, uint256 amount);

    // Add a new patient with insurance details
    function addPatient(string memory patientID, string memory insurancePolicy, string memory insuranceCompany, uint256 balance) public {
        require(bytes(companies[insuranceCompany].name).length != 0, "Invalid insurance company");
        require(bytes(policies[insurancePolicy].policyID).length != 0, "Invalid insurance policy");

        Patient memory newPatient = Patient({
            patientID: patientID,
            insurancePolicy: insurancePolicy,
            insuranceCompany: insuranceCompany,
            balance: balance
        });

        patients[patientID] = newPatient;
        emit PatientAdded(patientID);
    }

    // Add a new insurance policy
    function addInsurancePolicy(string memory policyID, string memory companyName, uint256 coverage, uint256 deductible) public {
        require(bytes(companies[companyName].name).length != 0, "Invalid insurance company");

        InsurancePolicy memory newPolicy = InsurancePolicy({
            policyID: policyID,
            companyName: companyName,
            coverage: coverage,
            deductible: deductible
        });

        policies[policyID] = newPolicy;
        emit InsurancePolicyAdded(policyID);
    }

    // Add a new insurance company
    function addInsuranceCompany(string memory name) public {
        companies[name] = InsuranceCompany(name);
        emit InsuranceCompanyAdded(name);
    }

    // Verify the insurance coverage for a patient
    function verifyInsurance(string memory patientID) public view returns (uint256) {
        Patient memory patient = patients[patientID];
        require(bytes(patient.patientID).length != 0, "Patient not found");
        
        InsurancePolicy memory policy = policies[patient.insurancePolicy];
        require(bytes(policy.policyID).length != 0, "Insurance policy not found");

        // Calculate available coverage after deductibles and patient balance
        uint256 availableCoverage = policy.coverage - policy.deductible - patient.balance;
        return availableCoverage;
    }

    // Clear a bill for a patient based on available insurance coverage
    function clearBill(string memory patientID, uint256 amount) public {
        Patient storage patient = patients[patientID];
        require(bytes(patient.patientID).length != 0, "Patient not found");

        InsurancePolicy memory policy = policies[patient.insurancePolicy];
        require(bytes(policy.policyID).length != 0, "Insurance policy not found");

        // Calculate available coverage after deductibles and balance
        uint256 availableCoverage = policy.coverage - policy.deductible - patient.balance;
        require(availableCoverage >= amount, "Insufficient insurance coverage");

        // Clear the bill from patient's balance
        patient.balance += amount;

        emit BillCleared(patientID, amount);
    }

    // List all insurance companies (returns just company names for simplicity)
    function listInsuranceCompanies() public view returns (string[] memory) {
        uint256 totalCompanies = 0;

        // Count the number of companies
        for (uint256 i = 0; i < 1000; i++) { // Adjust as per the number of companies
            if (bytes(companies[string(abi.encodePacked(i))].name).length != 0) {
                totalCompanies++;
            }
        }

        // Fill the array with company names
        string[] memory companyNames = new string[](totalCompanies);
        uint256 index = 0;
        for (uint256 i = 0; i < 1000; i++) {
            string memory companyName = companies[string(abi.encodePacked(i))].name;
            if (bytes(companyName).length != 0) {
                companyNames[index] = companyName;
                index++;
            }
        }

        return companyNames;
    }
}