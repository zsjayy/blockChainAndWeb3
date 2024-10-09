// SPDX-License-Identifier: MIT 
pragma solidity 0.8.7; 

contract TimeLock{
    //4个事件


    //2个装饰器
    modifier onlyOwner(){
        require(msg.sender == admin,"caller not admin");
        _;
    }
    
    modifier onlyTimeLock(){
        require(msg.sender == address(this),"caller not TimeLock");
        _;
    }

    //状态变量
    address public admin;
    uint public constant lock_duration = 150 seconds; //交易有效期，过期的交易作废
    uint public delay; //交易锁定时间
    //将交易追加到队列中
    mapping(bytes32 => bool) public queuedTransaction;

    //初始化
    constructor(uint _delay){
        admin = msg.sender;
        delay = _delay;
    }

    //更换admin,调用者必须是TimeLock合约
    function changeAdmin(address _newAdmin) external onlyTimeLock {
        admin = _newAdmin;
    }
    //获取当前时间戳
    function getBlockTimestamp() public view returns(uint){
        return block.timestamp;
    }

    //将交易追加到时间锁队列中
    function queuedTransactions(
        address target, //目标合约地址
        uint256 value, //发送的以太数量
        string memory signature, //要调用的函数签名（function signature）
        bytes memory data, //调用函数需要的参数
        uint256 executeTime //交易执行的区块链时间戳
    ) public onlyOwner returns(bytes32){
        //检查：交易执行时间满足
        require(executeTime >= (getBlockTimestamp() + delay),"invalid execute time");
        //哈希数据
        bytes32 txHash = getTxHash(target,value,signature,data,executeTime);
        require(!queuedTransaction[txHash],"transaction has exits");
        //将交易追加到队列中
        queuedTransaction[txHash] = true;
        return txHash;
    }

    //取消特定交易（即在时间锁内的交易）
    function cancelQueueTransaction(
        address target, //目标合约地址
        uint256 value, //发送的以太数量
        string memory signature, //要调用的函数签名（function signature）
        bytes memory data, //调用函数需要的参数
        uint256 executeTime //交易执行的区块链时间戳       
    ) public onlyOwner{
        bytes32 txHash = getTxHash(target,value,signature,data,executeTime);
        //检查：交易是否在时间锁队列中
        require(queuedTransaction[txHash],"transaction not in queued");
        //将交易移出时间队列
        queuedTransaction[txHash] = false;
    }

    //执行交易
    function executeTransaction(
        address target, //目标合约地址
        uint256 value, //发送的以太数量
        string memory signature, //要调用的函数签名（function signature）
        bytes memory data, //调用函数需要的参数
        uint256 executeTime //交易执行的区块链时间戳 
    )public payable onlyOwner returns (bytes memory){
        //制作txHash
        bytes32 txHash = getTxHash(target,value,signature,data,executeTime);
        //检查交易是否在时间锁队列中
        require(queuedTransaction[txHash],"transaction is not in queue");
        //检查交易当前时间是否大于交易时间
        require(getBlockTimestamp() >= executeTime,"invalid execute time");
        //检查交易是否在有效期内
        require(getBlockTimestamp() <= executeTime + lock_duration,"invalid lock_duration");
        //符合以上要求交易移出队列
        queuedTransaction[txHash] = false;

        bytes memory callData;
        if(bytes(signature).length == 0){
            callData = data;
        }else{
            callData = abi.encodePacked(bytes4(keccak256(bytes(signature))),data);
        }
        (bool success,bytes memory returnData) = target.call{value: value}(callData);
        require(success,"transaction failed");

        return returnData;

    }

    //定义制作txHash方法
    function getTxHash(
        address target,
        uint value,
        string memory signature, //要调用的函数签名（function signature）
        bytes memory data, //调用函数需要的参数
        uint executeTime //交易执行的区块链时间戳
    )public pure returns (bytes32){
        return keccak256(abi.encode(target,value,data,executeTime,signature));
    }
}