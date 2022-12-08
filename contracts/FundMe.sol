// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

// Imports the Price converter and attach to uint256

import "./PriceConverter.sol";

contract FundMe { 
    using PriceConverter for uint256;


    // lets keep track of the funders
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public owner;

    uint256 public minUsd = 50 * 1e18;
    
    // gets called immediately w hen you run FundMe
    constructor () {
        owner = msg.sender; //whoever deploys the contract
    }

    // contracts + wallet can hold tokens! :) 
    function fund() public payable {
        // to get the $ amount -> msg.value;

        // Use decentralized oracle net (ChainLink) to convert USD to ETH

        // 1*10^18 gwei = 1 ETH
        // require (getConversionRate(msg.value) >= minUsd, "Did not reach min. 1ETH fund");
        require (msg.value.getConversionRate() >= minUsd, "Did not reach min. 1ETH fund");


        // revert - undoes any actions and sends gas back
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {    

        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset array
        funders = new address[](0);

        // withdraw funds
        // transfer
        // payable(msg.sender).transfer(address(this).balance);
        
        // call - 
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Sorry the call failed");

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Sorry, the send failed");
    }

    // modifier - extract one line to a single keyword
    modifier onlyOwner{
        require(msg.sender == owner, "Sender is not the owner!!");
        _; // do the rest of the code, must be BELOW require
    }
}   