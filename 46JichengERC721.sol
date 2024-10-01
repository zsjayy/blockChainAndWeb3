// SPDX-License-Identifier: MIT 
pragma solidity 0.8.7; 

import "./ERC721.sol";
contract JichengERC721 is ERC721{

    //继承父合约的构造器
    constructor(string memory _name,string memory _symbol) ERC721(_name,_symbol){

    }

    function interfaceFun(address from,address to,uint256 tokenId)public{
        this.transferFrom(from,to,tokenId);
    }
}