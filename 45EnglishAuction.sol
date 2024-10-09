// SPDX-License-Identifier: MIT 
pragma solidity 0.8.7; 

//方法函数中如果包含msg.value,需要使用payable
interface IERC721 {
    function safeTransferFrom(address from,address to,uint tokenId) external;
    function transferFrom(address from,address to,uint tokenId) external;
}

contract EnglishAuction{
    uint startAt;
    uint duration;
    uint endAt;
    address public saller;
    address public highBidder;
    uint public highBidPrice;
    // uint startPrice;
    bool public isauctionActivity;
    address nftContract; //合约地址
    uint tokenId; //拍卖的代币ID
    //出价者=>出价
    mapping(address => uint) public bids;

    //当前出价人及出价
    event BidderLog(address indexed _bidder,uint indexed _bidPrice,uint _lastPrice);
    event BuyLog(address _buyer,uint _buyPrice);
    event RefundLog(address indexed _bidder,uint indexed _bidPrice,uint totalBidMoney);

    constructor(
        uint _duration,
        // address _saller,
        uint _startPrice,
        address _nftContract,
        uint _tokenId

    ){
        startAt = block.timestamp;
        duration = _duration;
        saller = msg.sender;
        highBidPrice = _startPrice;
        endAt = startAt + duration;
        nftContract = _nftContract;
        tokenId = _tokenId;
    }

    //check拍卖状态
    function auctionState() public view returns(bool){
        bool isAuctionActivity;
        if(block.timestamp >= endAt){
            return isAuctionActivity = false;
        }
        return isAuctionActivity = true;
    }
    //拍卖竞价过程
    function bid()external payable{
        uint previousBid = highBidPrice;
        //当highBidder为address(0)时，说明还没人出价，所以此时的出价人和出价为saller，startPrice
        if(highBidder != address(0)){
        //这里累加的意义是保证在调用refund()时，资金池里有足够多的金额退还
        bids[msg.sender] += highBidPrice;
        }
        highBidder = msg.sender;
        highBidPrice = msg.value;
        bids[highBidder] = highBidPrice;
       emit BidderLog(msg.sender, highBidPrice, previousBid);    
    }

    function refund()external{
        require(endAuction() != msg.sender,"newOwner cant refund");
        if(bids[msg.sender] !=0){
            uint refundBidPrice = bids[msg.sender];
            payable(msg.sender).transfer(refundBidPrice);
            bids[msg.sender] = 0;
            emit RefundLog(highBidder, refundBidPrice, bids[highBidder]);
        }else{
            revert("You did not bid anything yet");
        }
    }

    function endAuction()public returns(address) {
        address newOwner;
        require(!auctionState(),"auction is still biddinng");
        uint finalPrice = bids[highBidder];
        payable(saller).transfer(finalPrice);
        IERC721(nftContract).safeTransferFrom(saller,msg.sender,tokenId);
        emit BuyLog(msg.sender, finalPrice);
        return  newOwner = msg.sender;
    }
}