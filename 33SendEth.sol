// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 编写一个Solidity智能合约，包含以下功能：
// 1. 能够接收ETH（使用`receive`函数）。
// 2. 能够使用`transfer`方法发送ETH。
// 3. 能够使用`send`方法发送ETH并处理失败情况。
// 4. 能够使用`call`方法发送ETH并处理返回值。

contract SendEth{
    //构造器+payable，表明允许部署时向合约发送ether
    constructor() payable {}
    event Log(string Fun,uint gas);
    //当msg.data值为空的时候接受eth
    receive() external payable { }


    function queryAccount() external payable returns(uint){
        return address(this).balance;
    }

    function transferFun(address payable _to)external payable{
        _to.transfer(1);
        emit Log("transferFun", gasleft());
    }

    //send最终结果是个布尔类型，bool
    function sendFun(address payable _to) external payable {
        bool success = _to.send(1);
        require(success,"fail to send");
        emit Log("sendFun", gasleft());
    }

    function callFun(address payable _to) external payable{
        //格式_to.call{value:_amount}("")，（""）是为空的msg.data,这样receive才能接收到eth
        (bool success,) = _to.call{value:1}("");
        require(success,"call failed");
        emit Log("transferFun", gasleft());
    }
}