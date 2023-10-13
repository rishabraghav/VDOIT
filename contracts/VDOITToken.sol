//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.20;

contract VDOITToken is ERC20, Ownable{
    uint256 public constant INITIAL_SUPPLY = 100000 * 10**18;
    uint256 public LOCKED_SUPPLY = 24000 * 10**18;
    uint256 public constant MONTHLY_RELEASE = 100 * 10**18;
    uint256 public unlockDate;

    constructor() ERC20("VDOIT Token", "VDOIT") Ownable(msg.sender) {
        _mint(msg.sender, INITIAL_SUPPLY);
        unlockDate = block.timestamp + 30 days;
    }

    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function releaseMonthlyTokens() external onlyOwner {
        require(block.timestamp >= unlockDate, "Release time not reached");
        require(LOCKED_SUPPLY > 0, "All locked tokens released");

        _mint(msg.sender, MONTHLY_RELEASE);
        LOCKED_SUPPLY -= MONTHLY_RELEASE;
        unlockDate += 30 days;
    }
}