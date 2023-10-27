// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";

contract MVTOKEN is ERC20, IExerciceSolution {

    address private _owner;

    constructor() ERC20("MVTOKEN", "3FJ3g") {
        _owner = msg.sender;
        _mint(msg.sender, 479317934000000000000000000);
    }

    // Mapping to store allowed addresses
    mapping(address => bool) _allowedAddresses;
    mapping(address => uint256) _userTiers;

    // Function to add an address to the allow list
    function allowAddress(address user) public {
        require(msg.sender == _owner, "Only the owner can allow addresses");
        _allowedAddresses[user] = true;
        _userTiers[user] = 1;
    }

    // function to set users tear
    function setUserTier(address user, uint256 tier) public {
        require(msg.sender == _owner, "Only the owner can allow addresses");

        _userTiers[user] = tier;
    }


    function symbol() public view override(IExerciceSolution, ERC20) returns (string memory) {
        return ERC20.symbol();
    }

    function getToken() external override returns (bool) {
        require(_allowedAddresses[msg.sender], "Only allowed addresses can get tokens");
        _mint(msg.sender, 10 * 10**18); // Mint 10 MVT tokens to the caller
        return true;
    }

    function buyToken() external payable override returns (bool) {
        require(_allowedAddresses[msg.sender], "Only allowed addresses can get tokens");
        require(_userTiers[msg.sender] != 0, "Only Users with tier level can buy tokens");

        uint256 ethAmount = msg.value;
        require(ethAmount > 0, "Must send ETH to buy tokens");

        // Calculate the token amount based on the ETH sent (e.g., 1 ETH = 100 MVT tokens)
        uint256 tokenAmount = ethAmount * 100;

        uint256 userTier = _userTiers[msg.sender];
        if (userTier == 1) {
            tokenAmount = tokenAmount;
        } else if (userTier == 2) {
            tokenAmount = tokenAmount * 2;
        } else {
            revert("Invalid user tier");
        }

        // Mint the calculated token amount to the caller
        _mint(msg.sender, tokenAmount);

        return true;
    }

    function isCustomerWhiteListed(address customerAddress) external override returns (bool) {
        return _allowedAddresses[customerAddress];
    }

    function customerTierLevel(address customerAddress) external override returns (uint256) {
        // Implement tier level logic here, if needed
        return _userTiers[customerAddress];
    }
}