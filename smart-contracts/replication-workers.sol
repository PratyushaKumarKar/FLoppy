// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Import the web3.storage smart contract
import "./Web3Storage.sol";

contract ReplicationWorker {
    // Address of the deployed web3.storage smart contract
    address private web3StorageContractAddress;

    // Ban list of CIDs
    mapping(string => bool) private bannedCIDs;

    // Event emitted when replication is completed
    event ReplicationCompleted(string cid);

    constructor(address _web3StorageContractAddress) {
        web3StorageContractAddress = _web3StorageContractAddress;
    }

    function replicateFile(string memory cid) external {
        // Check if the CID is banned
        require(!bannedCIDs[cid], "CID is banned for replication");

        // Create an instance of the web3.storage smart contract
        Web3Storage web3Storage = Web3Storage(web3StorageContractAddress);

        // Call the replicate function of the web3.storage smart contract
        web3Storage.replicate(cid);

        // Emit an event to indicate completion of replication
        emit ReplicationCompleted(cid);
    }

    function banCID(string memory cid) external {
        // Mark the CID as banned
        bannedCIDs[cid] = true;
    }

    function unbanCID(string memory cid) external {
        // Remove the CID from the ban list
        bannedCIDs[cid] = false;
    }

    function isCIDBanned(string memory cid) external view returns (bool) {
        // Check if the CID is banned
        return bannedCIDs[cid];
    }
}
