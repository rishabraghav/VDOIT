// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract VDOITICO is Ownable {
    IERC20 public vdoitToken;

    uint256 public COIN_PRICE = 2 * 10**17;  // 0.2 USDT in Wei
    uint256 public HARD_CAP = 1000 * 10**18;
    uint256 public MIN_PURCHASE = 10 * 10**18;
    uint256 public MAX_PURCHASE = 200 * 10**18;

    uint256 public startTime;
    uint256 public endTime;

    mapping(address => uint256) public contributions;

    constructor(IERC20 _vdoitToken) Ownable(msg.sender){
        vdoitToken = _vdoitToken;
        startTime = block.timestamp;
        endTime = startTime + 30 days;
    }

    modifier isICOActive() {
        require(block.timestamp >= startTime && block.timestamp <= endTime, "ICO not active");
        _;
    }

    function buyTokens(uint256 usdtAmount) external isICOActive {
        require(usdtAmount >= MIN_PURCHASE && usdtAmount <= MAX_PURCHASE, "Invalid purchase amount");
        require(vdoitToken.totalSupply() + usdtAmount <= HARD_CAP, "Exceeds hard cap");

        uint256 tokenAmount = usdtAmount / COIN_PRICE;
        contributions[msg.sender] += usdtAmount;
        vdoitToken.transfer(msg.sender, tokenAmount);
    }

    function claimTokens() external {
        require(block.timestamp > startTime, "ICO not started yet");
        uint256 totalBuy = contributions[msg.sender];
        uint256 tokensToClaim = (totalBuy * 10) / 100;

        require(tokensToClaim > 0, "Nothing to claim");
        contributions[msg.sender] = 0;
        vdoitToken.transfer(msg.sender, tokensToClaim);
    }

    function setRate(uint256 newRate) external onlyOwner {
        require(newRate > 0, "Rate must be greater than 0");
        COIN_PRICE = newRate;
    }

    function transferCollectedUSDT(address owner) external onlyOwner {
        uint256 usdtBalance = vdoitToken.balanceOf(address(this));
        require(usdtBalance > 0, "No USDT to transfer");

        vdoitToken.transfer(owner, usdtBalance);
    }

    function stopICO() external onlyOwner {
        endTime = block.timestamp;
    }
}
