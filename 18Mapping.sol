// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Mapping{

    // dict = {
    //     "address1":1,
    //     "address2":2,
    //     "address3":3
    // };
    mapping(address => uint) public balances;
    function map1() external returns(uint){
        balances[msg.sender] = 123;
        uint bal = balances[msg.sender];
        return bal;
    }



    //     dict2 = {
    //     "address_a":{"address_A":true},
    //     "address_b":{"address_B":true},
    //     "address_c":{"address_C":true}
    // };
    // mapping(address => mapping(address => bool)) public isF;

}