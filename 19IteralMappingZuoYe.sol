// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 任务：实现一个Solidity合约，其中包括上述的`balances`, `keys`, 和 `inserted` 数据结构，以及`set`, `getSize`, 和一个能够根据索引返回余额的函数。
// - 要求：
// 1. 使用Solidity 0.8编写合约。
// 2. 实现一个`set`函数，用于向`balances`添加或更新条目，并处理`keys`和`inserted`。
// 3. 实现`getSize`函数返回当前`keys`数组的长度。
// 4. 实现函数，根据传入的索引返回相应地址的余额。
// 测试：
// 1. 向合约中添加几个不同的地址和余额。
// 2. 调用获取大小的函数确保大小正确。
// 3. 分别尝试获取第一个和最后一个元素的余额，确保返回正确。

contract IteralMappingZuoYe{
    mapping(address => uint) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address _addr,uint _value) external {
        balances[_addr] = _value;
        //这个判断完整的是if(inserted[_addr] != true,也就是说inserted的映射中不包含_addr:true这组键值对，就说明是新的地址，可以添加)
        if(!inserted[_addr]){
            inserted[_addr] = true;
            keys.push(_addr);
        }
    }

    function getSize() public view returns(uint){
        return keys.length;
    }

    function yuEr(uint i) external view returns(uint){
        return balances[keys[i]];
    }

    function firstAndLast() external view returns(uint,uint){
        uint fistAddress = balances[keys[0]];
        uint lastAddress = balances[keys[getSize()-1]];
        return (fistAddress,lastAddress);
    }
}