// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;

    // no function keyword
    receive() external payable {
        // can take funds if there is no data payload
        result = 1;
    }

    fallback() external payable {
        result = 2;
    }
}
