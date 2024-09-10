// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract DeleteArrary{
    uint[] public nums = [1,16,72,89,101,5];
    uint public indexNum;

    event numsChangeLog(uint[] newNums,uint numsLength);

    function deleteArrary(uint _indexNum)external returns(uint[] memory,uint){
        for(uint i=_indexNum;i<nums.length-1;i++){
            nums[i] = nums[i+1];
            emit numsChangeLog(nums,nums.length);
        }
        nums.pop();
        return (nums,nums.length);
    }

    function updateDeleteArrary(uint _indexNums)external returns(uint[] memory){
       uint updateValue = nums[_indexNums];
       uint lastIndex = nums.length-1;
       nums[lastIndex] = updateValue;
       nums.pop();
       return nums;
    }

}