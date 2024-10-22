// SPDX-License-Identifier: MIT 
pragma solidity 0.8.7; 
import "43IERC20.sol";


contract StakingRewards{
    // 质押代币的合约地址
    IERC20 public immutable stakingToken;
    // 奖励分配代币的合约地址
    IERC20 public immutable rewardToken;
    address public owner;

    /**
    以下这些状态变量来跟踪用户获得的奖励
    **/
    uint public duration;
    uint public finishAt;
    uint public updatedAt;
    uint public rewardRate;
    uint public rewardPerTokenStored;
    //每个用户存储的每个代币的奖励，跟踪
    mapping(address => uint) public userRewardPerTokenPaid;
    //记录用户获得的奖励
    mapping(address => uint) public rewards;

    /**
    以下这些状态变量来跟踪质押代币的总供应量，和每个用户的质押总额
    **/
    uint public totalSupply;
    //用户的质押金额
    mapping(address => uint) public balanceOf;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier updateReward(address _account){
        rewardPerTokenStored = rewardPerToken();
        updatedAt = lastTimeRewardApplicable();

        if(_account != address(0)){
            rewards[_account] = earned(_account);
            userRewardPerTokenPaid[_account] = rewardPerTokenStored;
        }

        _;
    }

    constructor(address _stakingToken, address _rewardToken){
        owner = msg.sender;
        stakingToken = IERC20(_stakingToken);
        rewardToken = IERC20(_rewardToken);
    }

    //设置质押期限,该方法只能合约拥有者执行
    function setRewardsDuration(uint _duration) external onlyOwner{
        //不允许在合约生效期间变更持续时间
        require(finishAt < block.timestamp,"staking is till doing.not finish");
        duration = _duration;
    }
    //设置期限内要支付的奖金
    function notifyRewardAmount(uint _amount) external onlyOwner updateReward(address(0)){
        //当前合约在有效期内
        if(block.timestamp > finishAt){ 
            //说明合约已经失效或者还没开始，这个时候奖励率为
            rewardRate = _amount/duration;
        }else{
            //说明合约正在进行中，此时的奖励率为
            uint remindRewards = (finishAt - block.timestamp) * rewardRate;
            rewardRate = (remindRewards + _amount)/duration;
        }
        require(rewardRate > 0,"rewardRate is 0");
        require(rewardRate * duration <= rewardToken.balanceOf(address(this)),"reardAmount > rewardToken");

        finishAt = block.timestamp + duration;
        rewardPerTokenStored = _amount * rewardRate / duration;
        updatedAt = block.timestamp;
    }
    //用户质押代币
    function stake(uint _amount) external updateReward(msg.sender){
        require(_amount > 0,"_amount = 0");
        stakingToken.transferFrom(msg.sender,address(this),_amount);
        //用户质押的代币数量
        balanceOf[msg.sender] += _amount;
        //代币的总供应量
        totalSupply += _amount;

    }
    //用户提取代币
    function withdraw(uint _amount) external updateReward(msg.sender) {
        require(_amount > 0,"_amount = 0");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
    }

    function lastTimeRewardApplicable() public view returns(uint){
        return min(block.timestamp,finishAt);
    }

    function rewardPerToken()public view returns(uint){
        if(totalSupply==0){
            return rewardPerTokenStored;
        }
        return rewardPerTokenStored + rewardRate * (lastTimeRewardApplicable() - updatedAt) * 1e18 /totalSupply;
    }
    //用户赚取的奖励金额
    function earned(address _account) public view returns(uint) {
        return (balanceOf[_account] * (rewardPerToken() - userRewardPerTokenPaid[_account]))/ 1e18 + rewards[_account];
    }
    //
    function getReward() external updateReward(msg.sender){
        uint reward = rewards[msg.sender];
        if(reward > 0){
            rewards[msg.sender] = 0;
            rewardToken.transfer(msg.sender, reward);
        }
    }

    function min(uint x,uint y) private pure returns(uint){
        return x<=y?x:y;
    }
}