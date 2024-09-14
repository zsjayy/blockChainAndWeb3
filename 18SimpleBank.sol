// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 任务：创建一个Solidity智能合约，实现一个简单的银行账户系统。
// 1. 合约名称：`SimpleBank`
// 2. 功能 ：
// - 创建一个公开的映射`balances`，键类型为`address`，值类型为`uint`。
// - 实现一个函数`deposit()`，允许用户为自己的账户存款。
// - 实现一个函数`withdraw(uint amount)`，允许用户从自己的账户中提取金额。
// - 实现一个函数`checkBalance()`，返回调用者的当前余额。

contract SimpleBank{
    mapping(address => uint) public blances;

    function deposit() public payable{
        blances[msg.sender] +=msg.value;
    }

    function withdraw(uint amount) public {
        require(blances[msg.sender] >= amount, "Insufficient funds");
        payable(msg.sender).transfer(amount);
        blances[msg.sender] -= amount;
    }

    function checkBlance() public view returns(uint){
        return blances[msg.sender];

    }
}