// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 作业：创建一个Solidity智能合约，名为`MessageStore`，包含以下功能：
// 一个公开的状态变量`message`用于存储一个字符串。
// -一个`setMessage`函数，允许用户输入一个字符串并将其存储到`message`状态变量中。该函数应使用calldata数据位置。
// - 一个`getMessage`函数，返回`message`状态变量的内容。该函数应声明为external，并使用memory数据位置。

contract MessageStorage{
    string public message;

    function setMessage(string calldata _message)external{
        message = _message;
    }

    function getMessage()external view returns(string memory){
        return message;
    }
}