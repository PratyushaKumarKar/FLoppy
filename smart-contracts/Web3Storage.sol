// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Strings.sol"; 

contract Web3Storage {
    using Strings for uint256;

    mapping(uint256 => string) private _data;

    event DataStored(uint256 indexed id, address indexed sender);
    event DataRetrieved(uint256 indexed id, address indexed sender);

    function storeData(string calldata data) external {
        uint256 id = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))).toString();
        _data[id] = data;

        emit DataStored(id, msg.sender);
    }

    function retrieveData(uint256 id) external view returns (string memory) {
        return _data[id];
    }
}