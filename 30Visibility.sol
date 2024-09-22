// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

//private--合约内部使用
//internal--合约内部及子合约使用
//public--合约外部或内部均能使用
//external--外部合约调用

contract Visibility{
    uint private x;
    uint internal y;
    uint public z;

    function privateFun() private pure returns(uint){
        return 123;
    }

    function internalFun() virtual internal pure returns(uint){
        return 345;
    }

    function publicFun() virtual public pure returns(uint){
        return 567;
    }

    function externalFun() external pure returns(uint){
        return 789;
    }

    function example() external view{
        x+y+z;
        privateFun();
        internalFun();
        publicFun();
    }
}

contract B is Visibility{
    function internalFun() override internal pure returns(uint){
        return 3455;
    }

    function publicFun() override public pure returns(uint){
        return 5677;
    }
}

contract C is Visibility{
    //读取状态变量的时候用view
    function example2() external view{
        y +z;
        //继承之后C合约只用使用这两个函数
        publicFun();
        internalFun();
    }

}