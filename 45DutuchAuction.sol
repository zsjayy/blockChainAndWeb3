// SPDX-License-Identifier: MIT 
pragma solidity 0.8.7; 
//荷兰拍卖是随着时间递减价格下降 
// 起始价格、最低价格、起始时间、结束时间、拍卖时长 
// 用ERC721铸造代币，将代币转给荷兰拍卖的合约，有人拍得后就把这个代币发给拍得者 
import "./ERC721.sol"; 

contract DutchAuction is ERC721{ 
    //immutable--是限制变量不可变。即这个变量一旦被赋值就不可更改
    uint256 public immutable startPrice;
    uint256 public immutable finalPrice;
    uint256 public startTime;
    uint256 public immutable endTime;
    uint256 public constant duration = 10 minutes;


    constructor(
        uint256 _startPrice,
        uint256 _finalPrice,
        string memory _name,
        string memory _symbol
    )ERC721(_name,_symbol){
        startPrice = _startPrice;
        finalPrice = _finalPrice;
        startTime = block.timestamp;
        endTime = startTime + duration;
    }

    function getCurrentPrice() public view returns(uint256){
        uint256 discount = (startPrice - finalPrice)/duration;
        return startPrice - (block.timestamp - startTime)*discount;
    }
    //这里的付钱是从当前账号的以太坊转出 
    function buy(address _from,address _to,uint _tokenId) external payable returns(bool){
        require(block.timestamp<= endTime,"time is expire"); 
        //买家需要输入对应的数额，msg.value就是获取买家的金额
        require(msg.value >= getCurrentPrice(),"your price is lower than currentPrice"); 
        this.transferFrom(_from,_to,_tokenId); 
        return true;
    } 
}