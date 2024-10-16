// SPDX-License-Identifier: MIT 
pragma solidity 0.7.4; 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 触发fallback() 还是 receive()?
//            接收ETH
//               |
//          msg.data是空？
//             /  \
//           是    否
//           /      \
// receive()存在?   fallback()
//         / \
//        是  否
//       /     \
// receive()   fallback()


contract WETH is ERC20{ 

    //事件
    event mintWethLog(address addr,uint256 value);

    event burnWethLog(address addr,uint256 amount);

    //设置代币的name和symbol
    constructor() ERC20("WETH", "WETH"){

    }

    //回调函数receive()--合约接收ETH时，msg.data为空且存在receive()时，会触发
    receive() external payable { 
        //接收到ETH后，调用存款函数，并铸造等量的WETH
        deposit();
    }
    //回调函数fallback()--合约接收ETH时，msg.data不为空且receive()不存在时，会触发
    fallback() external payable { 
        //接收到ETH后，调用存款函数，并铸造等量的WETH
        deposit();
    }
    
    //用户存钱进来时，将ETH包装铸造成等量的WETH
    function deposit() public payable{
        _mint(msg.sender,msg.value);
        emit mintWethLog(msg.sender, msg.value);
    }

    //用户将钱取走时，将铸造的WETH要销毁
    //用户需要输入取款的金额，将对应数量的WETH销毁
    function withdraw(uint256 amount) public{
        require(balanceOf(msg.sender)>= amount,"withdraw amount out of balanceOf");
        _burn(msg.sender,amount);
        payable(msg.sender).transfer(amount);
        emit burnWethLog(msg.sender, amount);
    }

    function queryBalanceOf()public view returns(uint256){
        return balanceOf(msg.sender);
    }

}