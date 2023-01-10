//get funds from users
//withdraw funds
// set minimum funds in usd

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./priceconverter.sol";


contract Fundme{
    using priceConverter for uint256; 

    uint256 public minimumUSD = 20 * 1e18;

    address[] public funders;
    mapping(address=>uint256) public addressToAmountFunded;


    function fund() public payable {
        //set minimum funds to be sent

        require(msg.value.getConvertionRate() >= minimumUSD , "the fund sent is insufficient");
        //save addresses of funders
        funders.push(msg.sender);
        //to check address and the amount funded
        addressToAmountFunded[msg.sender] = msg.value;
        
    } 


    function withdraw() public {
        /* format is (startingpoint;endpoint; stepamount)*/
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex = funderIndex + 1){
            //set funders amount of the specific index to variable funder  
        address funder = funders[funderIndex];
        // set the amount to 0
        addressToAmountFunded[funder] = 0;

        }
        //reset arrays
        funders = new address[](0);

        //ways to send eth 
        //transfer
        //payable(msg.sender).transer(address(this).balance);
        //call
        (bool callsuccess,) = payable(msg.sender).call{value : address(this).balance}("");
        require(callsuccess, "call failed");

                
    }
    


    

}