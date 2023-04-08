// get funds from user
//withdraw funds
//set a minium funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// import "./AggregatorV3Interface.sol"
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract FundMe {
        uint256 public minimumUsd = 50 * 1e18;

        address[] public funders;
        mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        //want to be able to set a minimum fund amount in USD 
        // 1. How do we send ETH to this contract?
        // number = 5;
        require(getConversionRate(msg.value) >= minimumUsd, "Did not send enough"); //10^18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

        //what is reverting?
        //undo any action before, and send remaining gas back
    }
    function getPrice() public view returns(uint256) {
        //abi
        //address  0xf99068a66aE783dCe4f7a811b09fe1CF071E4414
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xf99068a66aE783dCe4f7a811b09fe1CF071E4414);
        (, int256 price,,,) = priceFeed.latestRoundData();
        // ETH in terms of USD
        return uint256(price * 1e10);
    }
    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xf99068a66aE783dCe4f7a811b09fe1CF071E4414);
        return priceFeed.version();
    }
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice =getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;

     }
    //function withdraw{}{}

}