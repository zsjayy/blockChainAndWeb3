// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

//先对合约进行初始化，给一个最初的owner地址
//构造一个装饰器用来判断当前用户是否与初始化的用户相同
//相同才可以调用函数---只用owner才可以调用，
//不相同需要先更换owner，再进行调用，任何人都可以调用


contract Owner{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"not owner");
        _;
    }

    function onlyOwnerCan() external onlyOwner{
        //more code
    }

    function anyCan() external{
        //morecode
    }

    function setOwner(address _newOwner) external onlyOwner{
        require(_newOwner != address(0),"invalid owner");
        owner = _newOwner;
    }
}