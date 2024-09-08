// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract valueTypes{
    enum ActionSet {Buy, Hold, Sell}

    ActionSet action = ActionSet.Sell;

    function enumToUnit() external view returns(uint){
        return uint(action);
    }




}
