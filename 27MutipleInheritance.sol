// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 任务描述： 编写一个Solidity合约，展示多重继承的使用。包括以下几个步骤：
// 1. 定义三个合约A、B和C。
// - 合约A有一个函数`functionA`。
// - 合约B继承合约A，并重写`functionA`。
// - 合约C继承合约B和A，并重写`functionA`。
// 2. 确保继承顺序正确：从最基础的合约到派生合约。
// 3. 编译并部署合约C，验证合约C是否继承了所有的函数并重写成功。

contract MutipleInheritanceA{
    function A() external virtual pure returns(string memory){
        return "A";
    }
}

contract MutipleInheritanceB is MutipleInheritanceA{
    function A() external virtual override pure returns(string memory){
        return "B";
    }
}

contract MutipleInheritanceC is MutipleInheritanceA,MutipleInheritanceB{
    function A() external override(MutipleInheritanceA,MutipleInheritanceB) pure returns(string memory){
        return "C";
    }
}