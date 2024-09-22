// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;


// 请根据以下要求完成一个Solidity智能合约：
// 1. 创建一个名为`MyHash`的合约，其中包含以下功能：
// - 函数`hashFunction`：接受字符串`text`、整数`num`和地址`addr`作为参数，返回这些参数的Keccak256哈希值。
// - 函数`encodeFunction`：接受两个字符串`text0`和`text1`，使用`abi.encode`编码并返回结果。
// - 函数`encodePackedFunction`：接受两个字符串`text0`和`text1`，使用`abi.encodePacked`编码并返回结果。
// - 函数`collisionFunction`：接受两个字符串`text0`和`text1`，使用`abi.encodePacked`编码并返回Keccak256哈希值。
// 2. 编译并部署合约，测试以下功能：
// - 调用`hashFunction`函数，验证输入参数的哈希值。
// - 调用`encodeFunction`和`encodePackedFunction`，对比编码后的结果。
// - 调用`collisionFunction`，验证哈希冲突的发生，并通过添加一个额外的整数参数解决冲突。

contract Hash{
    //不读取状态变量用pure
    //hash值return要
    function hashFunction(string calldata text,uint num,address addr)external pure returns(bytes32) {
        return keccak256(abi.encodePacked(text,num,addr));
    }

    function encodeFunction(string calldata text0,string calldata text1)external pure returns(bytes memory){
        return abi.encode(text0,text1);
    }
    //encodePacked会对字节进行压缩，把中间的0给去掉，这会导致哈希的结果相同，比如A：AAA，B：BBB与A：AA，B：ABBB的结果是一样的
    //为了避免冲突，中间加一个uint类型
    function encodePackedFunction(string calldata text0,string calldata text1)external pure returns(bytes memory){
        return abi.encodePacked(text0,text1);
    }

    function collisionFunction(string calldata text0,string calldata text1)external pure returns(bytes32){
        return keccak256(abi.encodePacked(text0,text1));
    }

    function fixCollisionFunction(string calldata text0,uint num,string calldata text1)external pure returns(bytes32){
        return keccak256(abi.encodePacked(text0,num,text1));
    }
}