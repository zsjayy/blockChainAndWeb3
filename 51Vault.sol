// SPDX-License-Identifier: MIT 
pragma solidity 0.8.7; 
import "43IERC20.sol";


contract Vault{
    IERC20 public immutable token;
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    
    constructor(address _token){
        token = IERC20(_token);
    }

    function _mint(address _to, uint _amount) private  {
        totalSupply += _amount;
        balanceOf[_to] += _amount;
        token.transferFrom(address(this), _to, _amount);
    }

    function _burn(address _from,uint _amount) private {
        totalSupply -= _amount;
        balanceOf[_from] -= _amount;
    }


    //存款函数，用户往这个金库合约里存入amount
    //存入合约amount就需要铸造数量shares，s = at/b
    function deposit(uint _amount) external{
        uint shares;
        if(totalSupply == 0){
            shares = _amount;
        }else{
            shares = _amount * totalSupply/token.balanceOf(address(this));
        }
        _mint(msg.sender,shares);
        require(balanceOf[msg.sender]>=_amount,"you have enough amount to transfer");
        token.transferFrom(msg.sender,address(this),_amount);
    }

    function withdraw(uint _shares) external{
        uint amount = _shares * token.balanceOf(address(this))/totalSupply;
        _burn(msg.sender,_shares);
        token.transfer(msg.sender,amount);
    }
}