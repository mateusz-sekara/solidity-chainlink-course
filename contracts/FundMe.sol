//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

// https://www.npmjs.com/package/@chainlink/contracts
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 50 * 1e18;

    function fund() public payable {
        require (getConversionRate(msg.value) >= minimumUsd, "Didn't send enough");
    }

    function getPrice() public view returns(uint256) {
        // https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol
        // ABI
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ehtAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ehtAmountInUsd = (ethPrice * ehtAmount) / 1e18;
        return ehtAmountInUsd;
    }
}