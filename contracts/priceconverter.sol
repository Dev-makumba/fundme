 //SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library priceConverter{
    
    function getPrice() public view returns(uint256) {

        //since we using an external contract we'll need...
        //ABI
        //address= 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int price,,,) = priceFeed.latestRoundData();
        return (uint256(price * 1e10));
    }

    function getConvertionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethPriceinusd = (ethPrice * ethAmount) / 1e18;

        return ethPriceinusd;

    } 
}

 
 
 
 