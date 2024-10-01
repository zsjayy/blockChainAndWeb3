// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "./ERC721.sol";

contract WTFApe is ERC721{
    
    //设置发行代币的总量
    uint APE_MAX = 1000;

    constructor(string memory _name,string memory _symbol) ERC721(_name,_symbol){

    }

    //铸造代币
    function mint(address to,uint tokenId) external {
        require(tokenId >=0 && tokenId < APE_MAX);
        _mint(to,tokenId);
    }
}