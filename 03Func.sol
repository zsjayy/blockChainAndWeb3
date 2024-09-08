// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Func{
    //external-表示可以在网络上调用；pure表示只读
    function add (uint x,uint y) external pure returns(uint){
        return x+y;
    }

    function sub (uint x,uint y) external pure returns(uint){
        return x-y;
    }
}