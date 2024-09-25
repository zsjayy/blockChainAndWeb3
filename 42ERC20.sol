// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "./43IERC20.sol";
//部署验证步骤
// 1、部署后，给发行的代币命名，name、symbol
// 2、使用mint()铸造发行钱币，1000个----这个时候是发送给当前部署合约的账号（address(0)--->0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
// 3、通过第2步，此时当前账号已经拥有1000个JJZ代币，可以使用balanceOf查询
// 4、使用transfer()方法直接给账号0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2发1个JJZ代币（可继续通过allowance查询sender和recipient的代币资产是否都相应变化）
// 5、通过allowance给账号0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2分配25个JJZ代币额度（通过allowance查询当前账号35cb2总代币数量，此时应该有26(授权25+transfer1)）
// 5、通过transferFrom()从ddC4向其他账号转账---ddC4账号减去对应数量10，5cb2授权的额度减去对应数量10（注意这里并不是5cb2的账号金额减去10），目标账号增加相应数量10
//6个函数
//6个状态变量（包含两个mapping，balanceOf，allowance）
//2个事件

// interface IERC20 {
//     //总供应量
//     function totalSupply() external view returns(uint256);
//     //查询某个地址账户的余额
//     function balanceOf(address accout)external view returns(uint256);
//     //把钱转给某个接收账户地址
//     function transfer(address recipient, uint256 amount)external returns(bool);
//     //持有者授权第三方
//     function allowance(address owner,address spender)external view returns(uint256);
//     //在allowance的基础上，允许第三方spender花费多少钱
//     function approve(address speder,uint256 amount)external view returns(bool);
//     //在allowance的基础上，允许从sender向recipient赚钱，但是金额必须小于approve的金额
//     function transferFrom(address sender,address recipient,uint256 amount)external returns(bool);
// }


//只需要部署合约实现，不需要部署接口
contract ERC20 is IERC20{
    //设置发型代币的总量
    uint public override totalSupply;
    //查询账户的余额
    mapping(address => uint256)public override  balanceOf;
    //允许spender花费owner的多少amount
    //第一个address--表示拥有者，第二个address--表示信任方，uint表示允许信任方支配多少金额 
    mapping(address => mapping(address => uint)) public override allowance;

    //发型币的名称
    string public name = "Test";
    //发型币的简称或代称
    string public symbol = "Test";
    //发型币的进制10**18=1 Test Token
    uint8 public decimals = 18; 
    //初始化设置代币的名称和简称
    constructor(string memory _name,string memory _symbol){
        name = _name;
        symbol = _symbol;
    }


    //事件
    event transferLog(address indexed from,address indexed to,uint256 money);
    //持有者允许第三方多少额度支配
    event approveLog(address indexed owner,address indexed spender,uint256 money);

    function transfer(address recipient,uint256 amount)external override returns(bool){
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit transferLog(msg.sender,recipient,amount);
        return true;
    }

    function approve(address spender,uint256 amount)external override returns(bool){
        allowance[msg.sender][spender] = amount;
        emit approveLog(msg.sender,spender,amount);
        balanceOf[spender] += amount;
        return true;
    }

    function transferFrom(address from,address to,uint256 amount)external override returns(bool){
        //1、是靠第三方根据所支配的额度转账，所以会消耗spender的授权资金，所以授权金额要减掉本次的转账
        require(allowance[from][msg.sender]<= amount,"allowance money less than amount");
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit transferLog(from,to,amount);
        return true;

    }

    //铸造钱币，从address(0)发送给调用者
    function mint(uint amount)external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit transferLog(address(0), msg.sender, amount);
    }

    //销毁钱币，从调用者地址账号转给address(0)
    function burn(uint amount)external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit transferLog(msg.sender,address(0),amount);
    }
}