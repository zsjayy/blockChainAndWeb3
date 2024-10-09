// SPDX-License-Identifier: MIT 
pragma solidity 0.8.7; 

contract Abi{
    struct Mystruct{
        string name;
        uint[2] nums;
    }
    function encode(
        string calldata x,
        uint y,
        address addr,
        uint[] calldata arr,
        Mystruct calldata Mystructor
    )external pure returns(bytes memory){
        return abi.encode(x,y,addr,arr,Mystructor);
    }

    function decode(bytes calldata data)external pure returns(string memory x,uint y,address addr,uint[] memory arr,Mystruct memory Mystructor){
        (x,y,addr,arr,Mystructor)=abi.decode(data, (string,uint,address,uint[],Mystruct));
    }
}