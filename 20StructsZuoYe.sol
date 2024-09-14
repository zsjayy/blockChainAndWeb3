// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 创建一个Solidity智能合约，包含一个名为`Vehicle`的struct，具有以下属性：`make` (制造商，字符串类型)，`year` (生产年份，整数类型)，和`owner` (所有者，地址类型)。
// 合约应允许用户：msg.sender
// - 添加新的车辆到数组中。
// - 访问和修改特定车辆的年份。
// - 删除车辆记录。

contract StructsZuoYe{
    struct Vehicle {
        string make;
        uint year;
        address owner;
    } 

    Vehicle[] public cars;
    mapping(string => uint) public carsByOwner;

    function myCheKu(string memory _make,uint _year,address _owner) external{
        //保存入库车辆信息
        Vehicle memory addCars = Vehicle(_make,_year,_owner);
        cars.push(addCars);
        //将别名与车辆index映射起来(每增加一个车辆信息，就对应一个index)
        carsByOwner[_make] = cars.length-1;
    }

    function updateYear(string memory _make,uint newYear)external returns(Vehicle memory){
        uint i = carsByOwner[_make];
        require(i<cars.length);
        cars[i].year = newYear;
        return cars[i];
        // string memory updatedMake = cars[i].make;
        // uint updatedYear = cars[i].year;
        // return (updatedMake,updatedYear,msg.sender);
    }

    function deleteCars(string memory _make)external{
        uint delIndex = carsByOwner[_make];
        Vehicle storage delCars = cars[delIndex];
        delCars = cars[cars.length-1];
        cars.pop();
    }
}