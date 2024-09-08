// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract ValueTypes{
    //以下是最常用的数据类型
    bool public b = true;
    uint public u = 256; //uint是uint256的缩写，表示2**256次方，0～2**256-1，不能表示负数
    int public i = -128; //int是int256的缩写，表示2**256次方，-2**256～2**256-1
    address public addr = 0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1;
    bytes32 public b32 = 0x89c58ced8a9078bdef2bb60f22e58eeff7dbfed6c2dff3e7c508b629295926fa;
}