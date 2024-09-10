// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Modifier{
    bool public pasued; //初始值为false
    uint public count;

    function setPasued(bool _pasued) external {
        pasued = _pasued;
    }


    //装饰器的作用就是将相同的部分提取出来，可以共同使用
    // function inc() external{
    //     require(!pasued,"pasued");
    //     count +=1;
    // }

    // function dec() external{
    //     require(!pasued,"pasued");
    //     count -=1;
    // }

    //将require(!pasued,"pasued");这部分代码抽出来写成装饰器
    //modifier是装饰器的关键字，_;表示执行完装饰器里的代码后，再执行主函数里的代码
    modifier whenPasued(){
        require(!pasued,"pasued");
        _;
    }
    //装饰器基础用法
    //现在利用装饰器重新写inc()、dec()两个方法
    function inc() external whenPasued{
        count +=1;
    }

    function dec() external whenPasued{
        count -=1;
    }

    //装饰器input用法
    modifier modifierInput(uint _x){
        require(_x<100,"x>=100");
        _;
    }

    function sub(uint _x) external whenPasued modifierInput(_x){
        count +=_x;
    }

    //装饰器三明治用法前+主函数+后
    modifier sandwitch(){
        count +=1;
        _;
        count *=2;
    }

    function foo(uint _y) external sandwitch{
        count +=_y;
    }

}