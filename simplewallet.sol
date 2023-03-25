pragma solidity ^0.8.19;

contract SimpleWallet {
    address public owner;
    constructor() public {
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(owner == msg.sender, "You are not allowed");


    }
    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }

    function () external payable {

    }


}