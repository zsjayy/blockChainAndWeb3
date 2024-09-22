// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 1. 创建两个合约：`Caller`和`Callee`。
// 2. 在`Caller`合约中定义一个状态变量`num`。
// 3. 在`Callee`合约中定义一个函数`setNum`，接收一个`uint`参数并更新`Caller`合约中的`num`变量。
// 4. 在`Caller`合约中实现一个函数，通过delegatecall调用`Callee`合约的`setNum`函数。
// 5. 部署并调用这些合约，验证`num`变量的更新情况

contract Caller{
    uint public num;

}

contract Callee{
    function setNum(address _caller,uint _x)external{
         
    }

}