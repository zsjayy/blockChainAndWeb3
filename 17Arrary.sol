// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;


// 任务：编写一个Solidity智能合约，其中包含一个动态数组和一个固定大小数组，实现以下功能：
// 1. 初始化两个数组，一个动态数组`nums`初始化为`[1, 2, 3]`，一个固定大小数组`fixedNums`初始化为`[4, 5, 6]`。
// 2. 提供一个函数插入元素到动态数组`nums`。
// 3. 提供一个函数返回动态数组`nums`中的指定索引的元素。
// 4. 提供一个函数用于更新动态数组`nums`中的元素。
// 5. 提供一个函数删除动态数组`nums`的指定索引的元素。
// 6. 提供一个函数返回动态数组`nums`的长度。
// 提交要求：提交完整的Solidity源代码，并确保所有函数按预期运行。

contract Arrary{
    uint[] nums = [1,2,3];
    uint[3] fixedNNums = [4,5,6];
    uint public i;

    modifier indexNum(){
        require(i<=nums.length);
        _;
    }

    function addArrary(uint x)external{
        nums.push(x);
    }

    function returnArrary(uint _i)external view indexNum returns(uint){
        uint y1 = nums[_i];
        return y1;
    }

    function updateArrary(uint _i,uint m)external indexNum{
        nums[_i] = m;
    }

    function deleteArrary(uint _i)external indexNum {
        delete nums[_i];
    }

    function lengthArrary() public view returns(uint){
        uint len = nums.length;
        return len;
    }
}