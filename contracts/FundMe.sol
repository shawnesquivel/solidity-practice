// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract FundMe { 

    // contracts + wallet can hold tokens! :) 
    function fund() public payable {
        // to get the $ amount -> msg.value;
        uint256 minUsd = 50;

        // Use decentralized oracle net (ChainLink) to convert USD to ETH

        // 1*10^18 gwei = 1 ETH
        require (msg.value >= minUsd, "Did not reach min. 1ETH fund");

    }
    // function withdraw() private {


    // }


}