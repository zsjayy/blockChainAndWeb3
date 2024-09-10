// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 编写一个Solidity智能合约，包含一个整数类型的私有变量`number`。
// 实现一个函数修饰符`nonZero`，它确保任何修改`number`的函数只在`number`不为零时执行。
// 创建两个函数：`doubleNumber`和`resetNumber`。
// `doubleNumber`应用`nonZero`修饰符，每次调用时将`number`翻倍；`resetNumber`将`number`重置为0。

contract ModifierZuoYe {
    uint256 public number =2;

    // Modifier to ensure number is not zero
    modifier nonZero() {
        require(number != 0, "Number is zero and cannot be processed.");
        _;
    }

    function doubleNumber() external nonZero returns(uint) {
        number *= 2;
        return number;
    }

    function resetNumber() public {
        number = 0;
    }
}
