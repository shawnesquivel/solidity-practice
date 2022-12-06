// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// Manager of the SimepleStorages
contract StorageFactory {

    // comes with ABI
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
       SimpleStorage simpleStorage = new SimpleStorage();
       simpleStorageArray.push(simpleStorage);
    }

    // to interact with a contract, you need
    // 1) Address
    // 2) Application Binary Interface, ABI (how it interacts with contract)
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // pass the address of the simpleStorage contract into an instance of SimpleStorage[]
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    // Read from the simple storage contract -- gets the favoriteNumber
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }

}
