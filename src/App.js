import React, { useEffect, useState } from "react";
import initWeb3 from "./ethereum";
import Web3 from "web3";

function App() {
  const [coverage, setCoverage] = useState(null);
  const [loading, setLoading] = useState(true);  // Loading state
  const [error, setError] = useState("");

  useEffect(() => {
    const fetchData = async () => {
      try {
        const contract = await initWeb3();
        if (!contract) {
          setError("Failed to load contract");
          setLoading(false);
          return;
        }

        // Fetching the coverage for patient P1
        const coverage = await contract.methods.verifyInsurance("P1").call();

        // If the coverage is a BigNumber, convert it to a string or number
        const convertedCoverage = Web3.utils.fromWei(coverage.toString(), 'wei'); // Use this if the value is in Wei
        setCoverage(convertedCoverage);
      } catch (err) {
        setError("Error fetching coverage: " + err.message);
      } finally {
        setLoading(false);  // End the loading state
      }
    };

    fetchData();
  }, []);

  return (
    <div className="App">
      {loading ? (
        <h2>Loading...</h2>  // Loading message
      ) : error ? (
        <p style={{ color: "red" }}>{error}</p>  // Error message
      ) : (
        <h1>Insurance Coverage for Patient P1: {coverage}</h1>  // Display coverage
      )}
    </div>
  );
}

export default App;
