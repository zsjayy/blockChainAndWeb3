// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract ErrorWays{
    function requireError(uint _x) external pure{
        require(_x <10,"x>=10");
    }

    function revertError(uint _y) external pure{
        if(_y<10){
            //more code
            if(_y>=10 && _y<20){
            //more code
                if(_y>=20){
                    revert("_y>=20");
                }
            }
        }

    }
    //在这里声明状态变量=123
    uint public num =123;
    //因为要读取状态变量，所以要用view
    function assertError() external view{
        assert(num == 123);
    }

    //在这里有个函数调用了这个方法，改变了状态函数num的值，导致assert的结果为false
    //这就导致assert(num == 123)代码错误，会返还本次断言消耗的gas并撤销assert当前的状态值
    function foo() public  returns(uint){
        num +=1;
        return num;
    }

    //自定义错误和revert()是搭配使用的
    error MyError(address caller,uint i);
    function customError(uint _j) public view{
        if(_j<10){
            revert MyError(msg.sender,_j);
        }
    }
}