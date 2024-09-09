// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract ForAndWhile{
    function forLoops() external pure {
        for(uint i=0;i<10;i++){
            if(i==3){
                continue;
            }
            if(i==5){
                break;
            }
        }
    }

    function forWhile() external pure {
        uint j =0;
        while(j<10){
            j++;
        }
    }

    function sumFor(uint _x) external pure returns(uint){
        uint sum;// 默认值是0
        for(uint i=1;i<=_x;i++){
            sum = sum + i;
        }
        return sum;
    }

    function sumWhile(uint _y)external pure returns(uint){
        uint sum1;
        uint j=1;
        while(j<=_y){
            sum1 = sum1 + j;
            j++;  
        }
        return sum1;
    }
}