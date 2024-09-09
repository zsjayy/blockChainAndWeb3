### 心得01
当变量声明为public时才能在本地调用看得到

### 心得02
局部变量函数执行后就会消失
状态变量函数执行后还会存在

### 心得03
如果返回是字符串类型的话，需要用到memory关键字
因为在Solidity 中，字符串类型需要指定存储位置
```js
function ifEvent(uint _x) external view returns(string memory){
        if (_x<10){
            return res1;
        }else if (_x>=10 && _x<20){
            return res2;
        }else{
            return res3;
        }
    }
```
