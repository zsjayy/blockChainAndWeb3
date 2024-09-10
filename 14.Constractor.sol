// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Contractor{
    address public addr;
    uint public x;
    //构造器是部署完成后，初始化
    constructor(uint _x){
        addr = msg.sender;
        x = _x;
    }
}