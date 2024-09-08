// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract SimpleStorage{
    uint public storedData;

    function set(uint a) public {
        storedData = a;
        
    }

    function get() public view returns(uint){
        return storedData;
    }

}