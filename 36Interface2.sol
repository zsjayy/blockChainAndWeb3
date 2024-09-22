// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Interface2 {
    uint public count;

    function count1(uint _x) external returns(uint){
        count = _x;
        return count;
    }

    function increment() external{
        count += 1;
    }
}