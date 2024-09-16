// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 作业： 实现一个简单的智能合约，包括以下功能：

// 定义一个struct，包含一个字符串和一个整数数组。
// 实现两个函数：
// 1. 一个函数用于修改struct的字符串成员，该函数的参数为字符串，使用storage存储数据位置。
// 2. 另一个函数用于读取struct的整数数组成员，该函数的参数为整数数组，使用calldata存储数据位置，且在函数内部调用时，参数也使用calldata存储位置。



//storage可以用作修改链上的数据变量；memory在内存中使用它，calldata和memory也一样用于内存中，但是只能在入参中使用
//string、uint[]为动态数据类型，需要声明存储位置（calldata可以减少gas）
contract Storage{
    struct Stru{
        string str;
        //需要声明具体的uint类型和长度
        uint8[5] arry;
    }
    
    // Stru public stru_a;
    Stru public stru_b;
    constructor(){
        // stru_a.str = "abc";
        // stru_a.arry = [1,2,3,4,5];
        //要明确与结构中的uint类型保持一致
        uint8[5] memory arry_1 = [6,7,8,9,10];
        stru_b =Stru("abc",arry_1);
    }

    function updateStruct(string memory newStr)external{
        stru_b.str = newStr;
    }

    function getStruct()external view returns(uint8[5] memory){
        return stru_b.arry;

    }
}