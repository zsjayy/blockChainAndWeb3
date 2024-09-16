// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 目标：创建一个 Solidity 程序，包含三个合约：ContractA，ContractB 和 ContractC。
// ContractA：定义两个函数 `foo()` 和 `bar()`，返回字符串"A"。
// ContractB：继承 ContractA，重写 `foo()` 和 `bar()`，使其返回字符串"B"。
// ContractC：继承 ContractB，只重写 `bar()`，使其返回字符串"C"。
// 任务：编写完整的合约代码，编译并部署合约，验证函数调用的结果符合预期。

contract Inheritance{
    //如果该合约中的某个函数需要被另一个合约修改，需要使用virtual关键字
    function foo()external virtual  pure returns(string memory){
        return "foo-A";
    }

    function boo()external virtual pure returns(string memory){
        return "boo-A";
    }

    function baz()external pure returns(string memory){
        return "baz-A";
    }
}

contract B is Inheritance{
    //如果某个合约继承另一个合约并且需要修改自定义函数，需要使用关键字override
    //因为B继承了A，所以即使A中baz没有使用virtual，依旧可以被B调用
    function foo()external virtual override pure returns(string memory){
        return "foo-B";
    }

    function boo()external virtual override pure returns(string memory){
        return "boo-B";
    }  
} 

//多级继承
contract C is B{
    function foo()external override pure returns(string memory){
        return "foo-C";
    }

    function boo()external override pure returns(string memory){
        return "boo-C";
    }

}