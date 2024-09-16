// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 任务：编写一个 Solidity 程序，实现一个简单的待办事项列表。
// 要求：
// 1. 定义一个 `ToDo` 结构体，包含 `text`（任务描述）和 `completed`（是否完成）。
// 2. 创建一个 `ToDo[]` 数组来存储多个任务。
// 3. 实现 `create`, `updateText`, 和 `toggleCompleted` 函数。
// 4. 部署合约到测试网络，并通过界面或命令行测试各个函数的功能

contract TodoList{
    struct ToDo{
        string text; //任务描述
        bool completed; //是否完成
    }

    ToDo[] public todoList;

    //给每一组待办事项取个关键字，方便查找更改--用映射
    mapping(string => ToDo) public keyWords;
    //再创建一个映射，判断关键字是否存在
    mapping(string => bool) public keyIsExited;

    function createTodo(string calldata _text,string calldata key)external {
        ToDo memory tmptodo = ToDo({
            text:_text,
            completed:false
        });
        //将新增加的待办事项追加到列表中
        todoList.push(tmptodo);
        //将新追加的元素（即新的结构体映射到一个关键字中）
        require(!keyIsExited[key]);
        keyWords[key] = todoList[todoList.length-1];
        keyIsExited[key] = true;
    }

    function updateText(uint index,string calldata changeText,string calldata _key)public {
        // 先获取到想要更新的事项
        //如果只更新一个字段，用这种更节省gas
        todoList[index].text = changeText;
        todoList[index].completed = true;

        //如果要更新多个字段，需要用下的的更节省gas
        // ToDo storage todo = todoList[index];
        // todo.text = changeText;
        // todo.completed = true;

        //第二种方法修改--使用映射查找到要修改的待办事项
        keyWords[_key].text = changeText;

    }

    function getTodoList(uint index)external view returns(string memory,bool){
        ToDo memory todo = todoList[index];
        return(todo.text,todo.completed);
    }

    function toggleCompleted(uint _index)external {
        todoList[_index].completed = !todoList[_index].completed;
    }
}