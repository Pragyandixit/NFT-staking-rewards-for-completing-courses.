// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleNFTStaking {
    // NFT ownership mapping
    mapping(uint256 => address) public tokenOwner;
    mapping(address => uint256[]) public stakedTokens;

    // Events
    event Staked(address indexed user, uint256 tokenId);
    event Unstaked(address indexed user, uint256 tokenId);

    // Stake an NFT
    function stake(uint256 tokenId) external {
        require(tokenOwner[tokenId] == address(0), "Token already staked");

        // Simulate transfer to contract
        tokenOwner[tokenId] = msg.sender;
        stakedTokens[msg.sender].push(tokenId);

        emit Staked(msg.sender, tokenId);
    }

    // Unstake an NFT
    function unstake(uint256 tokenId) external {
        require(tokenOwner[tokenId] == msg.sender, "Not token owner");

        // Simulate transfer back to owner
        tokenOwner[tokenId] = address(0);

        // Remove from staked tokens
        uint256[] storage tokens = stakedTokens[msg.sender];
        for (uint256 i = 0; i < tokens.length; i++) {
            if (tokens[i] == tokenId) {
                tokens[i] = tokens[tokens.length - 1];
                tokens.pop();
                break;
            }
        }

        emit Unstaked(msg.sender, tokenId);
    }

    // View function to get all staked tokens for a user
    function getStakedTokens(address user) external view returns (uint256[] memory) {
        return stakedTokens[user];
    }
}
