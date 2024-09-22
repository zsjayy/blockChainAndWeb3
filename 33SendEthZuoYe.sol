// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 编写一个Solidity智能合约，包含以下功能：
// 1. 能够接收ETH（使用`receive`函数）。
// 2. 能够使用`transfer`方法发送ETH。
// 3. 能够使用`send`方法发送ETH并处理失败情况。
// 4. 能够使用`call`方法发送ETH并处理返回值。

contract SendEthZuoYe{
    //构造器+payable，表明允许部署时向合约发送ether
    // constructor() payable {}
    uint public account_money;
    event Log(string Fun,uint gas);
    // //当msg.data值为空的时候接受eth
    // receive() external payable { }


    function queryAccount() public view returns(uint){
        // account_money =  msg.sender.balance;
        // return account_money;
        return msg.sender.balance;
    }

    //如果想要调用前面的函数方法，需要该函数的可见性
    function transferFun(address payable _to)external payable{
        require(msg.value<=queryAccount(),"sender value more than account");
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