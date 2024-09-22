// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 编程作业,编写一个智能合约，实现以下功能：
// 1. `verify`函数，用于验证签名。
// 2. `getMessageHash`函数，用于生成消息哈希。
// 3. `getEthSignedMessageHash`函数，用于生成Ethereum签名消息哈希。
// 4. `recover`函数，用于恢复签名者地址。
// 5. `splitSignature`函数，用于拆分签名。
// #### 合约代码示例：
// ```
// solidity
// #### 测试步骤：
// 1. 部署合约。
// 2. 使用MetaMask签名消息。
// 3. 调用`verify`函数验证签名。


//整体流程：
//1、先写一段明文，在用keccak256进行一次哈希得到一个bytes32的哈希值；
//2、拿到明文的哈希值进行以太坊的消息哈希处理，得到处理过后的以太坊可用的消息哈希值；
//3、通过小狐狸进一步进行加密（前提是要把文本加工成以太坊规定的形式，也就是第二步在做的事情）；
//4、最后再通过recover和_splitSignature()演示验签的过程
contract VerifySign{
    //生成哈希消息
    function getMessageHash(string calldata _text)public pure returns(bytes32){
        return keccak256(abi.encodePacked(_text));
    }
    //生成Ether签名消息哈希
    //消息可以是能被执行的交易，也可以是其他任何形式。为了避免用户误签了恶意交易，
    //EIP191提倡在消息前加上"\x19Ethereum Signed Message:\n32"字符，并再做一次keccak256哈希，作为以太坊签名消息。
    //经过getEthSignedMessageHash函数处理后的消息，不能被用于执行交易:
    function getEthSignedMessageHash(bytes32 _getMessageHash)public pure returns(bytes32){
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32",_getMessageHash));
    }
    //恢复签名地址--这一步和_splitSignature()演示如何验签的过程
    function recover(bytes32 _getEthSignMessageHash,bytes calldata _sig)public pure returns(address){
        (bytes32 r,bytes32 s,uint8 v) = _splitSignature(_sig);
        return ecrecover(_getEthSignMessageHash,v,r,s);
    }
    //拆分签名 32+32+1一共是65的字节
    function _splitSignature(bytes memory _sig)internal pure returns(bytes32 r,bytes32 s,uint8 v){
        //先判断字节长度对不对
        require(_sig.length == 65,"invalid signature length");

        assembly{
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }
    //验证签名
    function verifySig(address _signer, string calldata _text, bytes calldata _sig)external pure returns(bool){
        bytes32 messageHash = getMessageHash(_text);
        bytes32 ethSignerMessageHash = getEthSignedMessageHash(messageHash);
        return recover(ethSignerMessageHash, _sig) == _signer;
    }

}