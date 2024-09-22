// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 实现一个简化版本的访问控制合约，包含以下功能：
// 1. 定义两个角色：`admin`和`user`
// 2. 实现分配和撤销角色的函数
// 3. 为合约部署者分配`admin`角色

contract AccessControl{

    //定义事件
    event GrantLog(bytes32 _role,string);
    event RevokeLog(bytes32 _role,string);
    //定义角色：角色--地址--true
    mapping(bytes32 => mapping(address => bool)) roles;
    //创建角色：ADMIN、USER
    //0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    //0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));
    //初始化，赋予当前地址为msg.sender的用户为ADMIN
    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    //设置一致修饰器，用在当前接口只能该用户操作
    modifier onlyOwner(bytes32 _role){
        require(roles[_role][msg.sender], "not allow current role operate!");
        _;
    }

    //
    function grantRole(bytes32 _role,address addr)external onlyOwner(ADMIN){
        _grantRole(_role, addr);
    }
    //赋予某个地址账号ADMIN的权限
    function _grantRole(bytes32 _role,address addr) internal {
        // require(addr != address(0) && roles[_role][addr],"current role not fuhe role requirement");
        roles[_role][addr] = true;
        emit GrantLog(_role,"grant ADMIN");
    }
    //去除某个地址账号ADMIN的权限
    function revokeRole(bytes32 _role,address addr)external onlyOwner(ADMIN){
        roles[_role][addr] = false;
        emit RevokeLog(_role,"revoke ADMIN");
    }

    function queryRole(bytes32 _role,address _addr)external view returns(string memory){
        string memory res1 = "is ADMIN";
        string memory res2 = "is USER";
        if (roles[_role][_addr]){
            return res1;
        }else{
            return res2;
        }
    }


}