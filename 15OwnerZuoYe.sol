// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 任务：编写一个简单的 Solidity 合约 `MyOwnable`。
// 要求：
// 1. 合约中应包含一个状态变量 `owner`，标记为 `public`。
// 2. 使用构造函数来设置部署者为 `owner`。
// 3. 创建 `onlyOwner` 修饰符，使得某些函数只能由 `owner` 调用。
// 4. 实现一个 `transferOwnership` 函数，允许 `owner` 更改所有者（新所有者不能为零地址）。
// 5. 部署合约并测试功能，确保权限控制有效。
// 额外挑战：添加一个函数，该函数任何人都可以调用，但要记录调用次数，并仅允许所有者能重置此计数
contract MyOwnable{
    address public owner;
    uint public count; 

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"not owner");
        _;
    }

    function transferOwnership(address _newOwner) external onlyOwner{
        require(_newOwner != address(0),"invalid address");
        owner = _newOwner;
    }

    function anyCanCall() external{
        if (msg.sender == owner){
            count = 0;
        }else{
            count +=1;
        }
        
    }
}