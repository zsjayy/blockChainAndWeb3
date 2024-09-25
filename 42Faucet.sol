// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "./42ERC20.sol";

//ERC20合约部署后创建代币，将铸造的代币发到本合约地址上
contract Faucet{
    address public tokenContract;
    //每次能领多少代币
    uint constant requestAmount = 100;
    //创建映射，表明该地址已经领过
    mapping(address => bool) public isRequestedAddr;

    constructor(address _tokenContract) {
        tokenContract = _tokenContract; // set token contract
    }

    IERC20 token = ERC20(tokenContract);

    event requestTokenLog(address indexed recipient,uint256 indexed requestAmount);
    function requestToken()public returns(bool){
        //先判断当前账号是不是已经被领过了
        require(!isRequestedAddr[msg.sender],"current had requested before");
        //再判断还有没有钱转出来，有没有被领光
        require(token.balanceOf(address(this)) >= requestAmount,"money over");
        //通过ERC20的transfer()方法，给当前调用账号转入100代币
        token.transfer(msg.sender,requestAmount);
        //将当前领取代币的账号地址记录下来，避免多次领取
        isRequestedAddr[msg.sender] = true;
        emit requestTokenLog(msg.sender,requestAmount);
        return true;

    }

    function transferOver(address recipient,uint256 amount)external returns(bool){
        token.transfer(recipient,amount);
        return true;
    }
}