// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Event{
    event messageLog(string message,int val);
    event indexedLog(address indexed _from,address indexed _to,string meaasge);
    function event1()external{
        emit messageLog("rizhifanhui", 1234);
    }

    
    function event2(address _to,string calldata message)external{
        emit indexedLog(msg.sender,_to,message);
    }
}