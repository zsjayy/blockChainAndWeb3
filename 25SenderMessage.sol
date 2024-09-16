// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 请按照以下要求编写一个 Solidity 智能合约，完成练习：
// 1. **声明事件**：
// - 声明一个名为LogMessage的事件，包含以下参数：
// - 发送者地址（`address`，使用 `indexed` 关键字）
// - 接收者地址（`address`，使用 `indexed` 关键字）
// - 消息内容（`string`）
// 2. **创建发送消息的函数**：
// - 创建一个名为sendMessage 的函数，该函数包含两个参数：
// - 接收者地址（`address`）
// - 消息内容（`string`）
// - 在函数内部，使用 `emit` 记录 `LogMessage` 事件，将发送者地址设为 `msg.sender`，接收者地址设为函数参数，消息内容设为函数参数。
// 3. **部署和测试**：
// - 部署智能合约并测试 `sendMessage` 函数，确保事件正确记录在区块链上。

contract SenderMessage{
    //这里indexed的作用是讲对应的参数可以存储在日志的索引部分，方便查询效率，每个事件索引最多为3个
    event LogMessage(address indexed _from,address indexed _to,string message);
    function sendMessage(address _to,string calldata _message)external{
        emit LogMessage(msg.sender,_to,_message);
    }
}