// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

// Imports the 
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe { 

    // lets keep track of the funders
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // contracts + wallet can hold tokens! :) 
    function fund() public payable {
        // to get the $ amount -> msg.value;
        uint256 minUsd = 50 * 1e18;

        // Use decentralized oracle net (ChainLink) to convert USD to ETH

        // 1*10^18 gwei = 1 ETH
        require (getConversionRate(msg.value) >= minUsd, "Did not reach min. 1ETH fund");

        // revert - undoes any actions and sends gas back
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

        // We could make this public, but then we'd have to deploy it
    function getPrice() internal view returns (uint256) {
        // Goerli ETH / USD Address
        // https://docs.chain.link/docs/ethereum-addresses/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate is in 18 digit
        return uint256(answer * 1e10);
        // or (Both will do the same thing)
        // return uint256(answer * 1e10); // 1* 10 ** 10 == 10000000000
    }

    // convert msg.value to dollars
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        // Get the price in ETH/USD
        uint256 ethPrice = getPrice(); // usd/eth
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;
        return ethAmountInUsd;
    }


     function getVersion() public view returns (uint256){
        // ETH/USD price feed address of Goerli Network.
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }
    // function withdraw() private {

    // }

}