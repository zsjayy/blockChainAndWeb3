// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 任务描述： 请编写一个 Solidity 合约，其中包含一个基础合约和两个继承该基础合约的子合约，再创建一个继承自这两个子合约的合约。在这个合约中：
// 1. 使用直接调用的方式调用父合约的一个函数。
// 2. 使用 `super` 关键字调用父合约的另一个函数。
// **要求**：
// 基础合约应包含两个函数，并使用事件记录日志。
// 子合约应覆盖基础合约中的函数。
// 复合继承合约应调用子合约中的函数，并演示直接调用和使用 `super` 的区别。


contract CallingParentFunction{

}



//基础合约
contract A{
    event Log(string message);
    function foo() virtual public{
        emit Log("A-foo");
    }

    function bar() virtual public{
        emit Log("A-bar");
    }
}

//子合约1--直接调用
contract B is A{
    function foo() virtual override public{
        emit Log("B-foo");
        A.bar();
    }

    function bar() virtual override public{
        emit Log("B-bar");
    }

}


//子合约2--super
contract C is A{
    function foo() virtual override public{
        emit Log("C-foo");
        super.foo();
    }

    function bar() virtual override public{
        emit Log("C-bar");
        A.bar();
    }
}

//合约3--继承B、C
contract D is B,C{
    //super会同时去追溯继承B，C及B/C所继承方法
    function foo() override(B,C) public{
        emit Log("D-foo");
        super.foo();  //约等于B.foo(),C.foo()
    }
    //只会去继承C及C继承的方法
    function bar() override(B,C) public{
        emit Log("D-bar");
        C.bar();
    }
}