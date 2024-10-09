// SPDX-License-Identifier: MIT 
pragma solidity 0.8.7; 

//委托调用：通过A合约调用自己的B合约
//注意：1、只能调用自己的合约；2、委托调用返回的是原合约的msg.sender,多重调用返回的是调用合约（即上一个合约的msg.sender）;3、委托调用合约不能单出存在

contract MultiDelegateCall{

    error DelegateCallFail();
    function multiDelegateCall(bytes[] calldata data) external payable returns (bytes[] memory results){
        results = new bytes[](data.length);
        for (uint i;i<data.length;i++){
            (bool ok,bytes memory res)= address(this).delegatecall(data[i]);
            if(!ok){
                revert DelegateCallFail();
            }
            results[i] = res;
        }
    }
}

contract TestMultiDelegateCall is MultiDelegateCall{
    event Log(address caller,string func,uint i);
    function func1(uint x,uint y)external {
        emit Log(msg.sender, "func1", x + y);
    }

    function func2()external returns(uint){
        emit Log(msg.sender, "func2", 2);
        return 111;
    }
}

//制作func1、func2两个函数的data
contract Helper{
    function getFunc1Data(uint x,uint y)external pure returns(bytes memory){
        return abi.encodeWithSelector(TestMultiDelegateCall.func1.selector,x,y);
    }

    function getFunc2Data()external pure returns(bytes memory){
        return abi.encodeWithSelector(TestMultiDelegateCall.func2.selector);
    }
}