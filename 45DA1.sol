// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
//该合约实现：将WTFApe合约铸造的tokenId = 0的代币进行荷兰拍卖
//合约使用：
//1、先使用WTFApe合约进行代币铸造，如铸造一个代币tokenId=3的代币
//2、部署合约DA1
//3、通过合约WTFApe中approve方法赋予合约DA1地址代币3的权限，可以托管代币3的转移及支付

//ERC721是完整的ERC721标准的接口实现，IERC721是接口标准
import "./IERC721.sol";

contract DA1{
    //将荷兰拍卖所需的相关变量等整理成struct
    struct Auction{
        uint startPrice; //起拍价
        uint endPrice; //最低价
        uint startTime; //拍卖开始时间
        uint duration;  //拍卖结束时间
        uint tokenId; //所要拍卖的代币Id
        uint currentTime; //当前时间
        uint endTime; //结束时间
        address seller; //卖家地址
        address nftContract; //NFT合约地址
    }

    Auction public auction;

        //初始化拍卖相关信息
    constructor(
        uint _startPrice,
        uint _endPrice,
        uint _tokenId,
        address _nftContract,
        address _seller

    ){
        auction.startPrice = _startPrice;
        auction.endPrice = _endPrice;
        auction.startTime = block.timestamp;
        auction.duration = 100 minutes;
        auction.nftContract = _nftContract;
        auction.seller = _seller;
        auction.tokenId = _tokenId;
        auction.endTime = auction.startTime + block.timestamp;
        auction.currentTime = block.timestamp;
    }

    event buyLog(address _who,uint _price,uint _time);

    function getCurrentPrice()public view returns(uint){
        //拍卖仍在继续没有结束
        require(block.timestamp <= auction.startTime + auction.duration,"Auction is expired");
        uint discount = (auction.startPrice - auction.endPrice)/auction.duration;
        if (block.timestamp >= auction.startTime + auction.duration){
            return auction.endPrice;
        }else{
            uint currentPrice = auction.startPrice - (block.timestamp - auction.startTime)*discount;
            return currentPrice;
        }
    } 

    //要进行支付，需要用payable
    function buy() external payable returns(uint){
        //拍卖仍在继续没有结束
        require(block.timestamp <= auction.startTime + auction.duration,"Auction is expired");
        //代币未被买走
        require(IERC721(auction.nftContract).ownerOf(auction.tokenId) == auction.seller,"NFT has bought by others");
        //校验用户付款金额不能少于当前价格
        require(msg.value >= getCurrentPrice(),"Your price is lower than currentPirce!");
        //将代币转移给买家
        IERC721(auction.nftContract).safeTransferFrom(auction.seller,msg.sender,auction.tokenId);
        //如果此时tokenId为0的代币已经属于买家了，进行转账操作
        if (IERC721(auction.nftContract).ownerOf(auction.tokenId) == msg.sender){
            payable(auction.seller).transfer(getCurrentPrice());
            return getCurrentPrice();
        }else{
            return msg.value;
        }

    }

    function refund() external payable{
        if(msg.value > getCurrentPrice()){
            payable(msg.sender).transfer(msg.value - getCurrentPrice());
        }
    }

    // function auctionAction() private{
    //     if(block.timestamp > auction.startTime + auction.duration){
    //         delete auction;
    //     }
    // }
}