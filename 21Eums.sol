// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 任务：编写一个Solidity智能合约，实现一个简单的订单处理系统。
// 声明一个名为 `OrderStatus` 的枚举，包括状态：`None`, `Pending`, `Shipped`, `Completed`, `Rejected`, `Cancelled`。
// - 创建一个结构体 `Order`，包含买家地址和订单状态。
// - 实现功能：
// 1. 添加新订单到数组。
// 2. 更新订单状态。
// 3. 获取特定订单的状态。
// 4. 重置订单状态到默认值。
// 提示：利用已学习的枚举操作和智能合约基础知识，完成作业。



contract Enum {
    enum Status {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }
    Status public status;
    struct Order {
        address buyer;
        Status status;
    }
    Order[] public orders;
    function get() external view returns (Status){
        return status;
    }
    function set(Status _status) external {
        status =_status;
    }
    function ship() external {
        status = Status.Shipped;
    }
    function reset() external {
        delete status;
    }
}
