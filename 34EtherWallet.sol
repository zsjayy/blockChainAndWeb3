// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 编写一个简单的以太坊智能合约 EtherWallet，要求如下：
// 1. 合约可以接收以太币。
// 2. 只有合约所有者可以提取以太币。
// 3. 合约中有一个函数可以返回当前存储的以太币余额。

contract EtherWallet{
    //定义一个全局变量
    address payable public owner;

    //初始化使owner等于当前部署用户合约地址
    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable { }

    function withdraw(uint _amount)external {
        //调用这个函数的caller就是owner
        require(msg.sender==owner,"caller is not owner");
        owner.transfer(_amount);
    }

    function queryAccount()external view returns(uint){
        return address(this).balance;
    }
}