// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract LocalVariables{
    //状态变量，即使函数执行完成后仍会存在
    uint public i;
    bool public b;
    address public myAddress;

    function foo() external {
        uint x = 123;
        bool y = false;

        x += 456;
        y = true;

        i = 123;
        b = true;
        myAddress = address(1); 
    }
}