// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// contract ProcessNumber{
//     string public res1 = "xiaoyu10";
//     string public res2 = "xiaoyu10,dayu20";
//     string public res3 = "dayu20";
//     //加memory是因为在 Solidity 中，字符串类型需要指定存储位置
//     function ifEvent(uint _x) external view returns(string memory){
//         if (_x<10){
//             return res1;
//         }else if (_x>=10 && _x<20){
//             return res2;
//         }else{
//             return res3;
//         }
//     }
// }

contract ProcessNumber{
    string public res1 = "xiaoyu10";
    string public res2 = "xiaoyu10,dayu20";
    string public res3 = "dayu20";
    function ifEvent2(uint _x) external view returns(string memory){
        return _x<10?res1:_x>=10 && _x<20?res2:res3;

    }
}