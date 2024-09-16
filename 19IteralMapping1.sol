// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract IteralMapping{
    mapping(address => uint) public balances;
    //地址=>true or false
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address _key, uint _val) external{
        //balances赋值一组key和value
        balances[_key] = _val;
        //***这里的意思其实是直接去inserted里去查，看看是否已经有一组_key:true的键值对
        //***当instered[_key] !=true的时候，说明iserted里面还不存在一组_key:true,所以才可以继续往里面赋值
        if(!inserted[_key]){
            //发现还不存在_key，可以往inserted里面赋值
            inserted[_key] = true;
            //赋值成功后再将_key追加到列表keys[]中
            keys.push(_key);
        }
    }

    function getSize() external view returns(uint){
        return keys.length;
    }

    function first() external view returns(uint){
        return balances[keys[0]];
    }

    function last() external view returns(uint){
        return balances[keys[keys.length-1]];
    }

    function get(uint _i) external view returns(uint){
        return balances[keys[_i]];
    }
}