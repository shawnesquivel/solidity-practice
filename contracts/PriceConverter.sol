// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";



// attach a library

library PriceConverter{ 
    // 1. functions are all internal
    // 2. cannot have state variables
    // 3. cant send ether
      // We could make this internal, but then we'd have to deploy it
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
    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        // Get the price in ETH/USD
        uint256 ethPrice = getPrice(); // usd/eth
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;
        return ethAmountInUsd;
    }


     function getVersion() internal view returns (uint256){
        // ETH/USD price feed address of Goerli Network.
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }
    


}