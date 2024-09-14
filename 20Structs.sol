// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Structs{
    struct Car{
        string model;
        uint year;
        address owner;
    }

    // Car public car;
    Car[] public cars;
    mapping(address => Car[]) public ownerByCars;

    function example() external{
        //memroy--存储在代码函数方法内存中，不会上链，不会改变状态变量;以下是三种Car的声明方式
        //第一种
        Car memory toyota = Car("toyota",1998,msg.sender);
        //第二种--键值对
        Car memory lixiang = Car({model:"lixiang",year:1999,owner:msg.sender});
        //第三种--赋值
        Car memory tesla;
        tesla.model = "tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;


        cars.push(toyota);
        cars.push(lixiang);
        cars.push(tesla);
        //storage--改变状态变量后存储到链上，方法执行后状态变量还在
        Car storage _car = cars[0];
        delete _car.owner;
        delete cars[1];
    }
}