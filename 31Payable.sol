// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 请基于所学内容，编写一个简单的 Solidity 合约，包含以下要求：
// 1. 定义一个 `payable` 函数 `receiveEther`，用于接收以太币。
// 2. 创建一个 `payable` 地址 `recipient`，并在构造函数中初始化为 `msg.sender`。
// 3. 编写一个函数 `queryBalance`，返回合约当前的以太币余额。
// 4. 确保在未使用 `payable` 关键字时，合约无法接收以太币，并记录错误日志。

contract Payable{
    address payable public recipient;
    constructor() {
        //因为上述声明的recipient事payable类型，所以这里的msg.sender也应该是payable类型
        recipient = payable(msg.sender);
    }

    receive() external payable {  
        // 这里可以添加一些逻辑，例如将收到的以太币转账给 recipient  
    } 
    
    function receiveEther() external payable {}

    function queryBalance()external view returns(uint){
        return address(this).balance;
    }

    fallback() external payable {
        revert("Function not Payable");
     }
}