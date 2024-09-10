// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
// 任务：编写一个Solidity合约，包含三个函数：
// 1. `returnMultiple()`：返回三个输出，分别是一个整数、一个布尔值和一个字符串。
// 2. `captureOutputs()`：使用解构赋值从`returnMultiple()`捕获这三个输出并存储到合约的状态变量中。
// 3. `displayOutputs()`：读取这些状态变量，并返回它们的值。
// 目标：理解如何从函数中返回多个输出，并在合约内部使用解构赋值。
contract Outputs{
    uint public i;
    bool public b;
    string public s;
    function returnMultiple() public pure returns(uint,bool,string memory){
        return(1,true,"abc");
    }

    function captureOutputs() public{
        (i, b, s) = returnMultiple();
    }

    function displayOutputs() public view returns(uint,bool,string memory){
        return(i,b,s);
    }
} 