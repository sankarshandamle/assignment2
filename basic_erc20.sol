// SPDX-License-Identifier: MIT
pragma solidity ^0.7.5;

/*
 * Assignment: Implement a basic ERC-20 token contract. 
 * Follow the TODOs and complete the missing code where instructed.
 */

interface Token {

    // Function to return the total supply of the token.
    function totalSupply() external view returns (uint256 supply);

    // Function to get the balance of a given address.
    function balanceOf(address _owner) external view returns (uint256 balance);

    // Function to transfer tokens from the sender to another address.
    function transfer(address _to, uint256 _value) external returns (bool success);

    // Function to transfer tokens from one address to another with approval.
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);

    // Function to approve another address to spend tokens on behalf of the sender.
    function approve(address _spender, uint256 _value) external returns (bool success);

    // Function to check the amount of tokens an address is allowed to spend on behalf of another address.
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

    // Events to notify transfer and approval actions
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value); 
}

// XYZToken inherits the functionality of the Token contract
contract XYZToken is Token {
    
    /* === State Variables === */

    // Public variables accessible to everyone
    string public name;
    uint8 public decimals;
    string public symbol;
    uint256 public unitsOneEthCanBuy;
    uint256 public totalEthInWei;
    address public fundsWallet;

    // Mappings to track balances and allowances
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;

    // The total supply of the token
    uint256 override public totalSupply;

    /* === Constructor === */
    // Initialize token details, supply, and assign the entire supply to the creator.
    constructor() {
        // TODO: Try and change the balances, totalSupply, name, symbol, and unitsOneEthCanBuy.
        // Set totalSupply and token properties.
        // Ensure that the totalSupply is assigned correctly and that unitsOneEthCanBuy reflects the rate of XYZ tokens per ETH.
        name = "XYZToken";
        decimals = 18;
        symbol = "XYZ";
        unitsOneEthCanBuy = 10;
        fundsWallet = msg.sender;
        totalSupply = 1000000000000000000000;  // Set a supply value
        balances[msg.sender] = totalSupply;   // Assign all tokens to the contract creator
    }

    /* === Main Functions === */

    // Transfer tokens from the sender to another address
    function transfer(address _to, uint256 _value) external override returns (bool success) {
        // TODO: Implement the transfer logic.
        // Ensure the sender has enough tokens, the recipient’s balance doesn’t overflow,
        // and emit the Transfer event after a successful transfer.

        return true;
    }

    // Transfer tokens from one address to another with allowance check
    function transferFrom(address _from, address _to, uint256 _value) external override returns (bool success) {
        // TODO: Implement the transferFrom logic.
        // Check that the sender has enough tokens, the allowance is sufficient,
        // the recipient’s balance doesn’t overflow, and emit the Transfer event.

        
        return true;
    }

    // View function to get the balance of an address
    function balanceOf(address _owner) external view override returns (uint256 balance) {
        // TODO: Return the balance of the specified address from the balances mapping.
    }

    // Approve another address to spend tokens on behalf of the sender
    function approve(address _spender, uint256 _value) external override returns (bool success) {
        // TODO: Set the spender's allowance in the allowed mapping.
        // Emit the Approval event to notify that the spender has been approved to spend the specified amount.
        
        return true;
    }

    // Check the allowance an address has to spend tokens on behalf of another address
    function allowance(address _owner, address _spender) external view override returns (uint256 remaining) {
        // TODO: Return the allowance set by the owner for the spender in the allowed mapping.
    }

    // Fallback function to handle ETH transfers and issue XYZ tokens
    receive() external payable {
        // TODO: Implement logic for receiving ETH and issuing the corresponding amount of XYZ tokens.
        // Ensure the funds wallet has enough tokens to send to the sender.
        // Emit the Transfer event when tokens are transferred to the sender.
        uint256 amount = msg.value * unitsOneEthCanBuy;
        require(balances[fundsWallet] >= amount, "Insufficient tokens in funds wallet");

        balances[fundsWallet] -= amount;
        balances[msg.sender] += amount;
        
        emit Transfer(fundsWallet, msg.sender, amount);

        // Transfer the received Ether to the funds wallet
        payable(fundsWallet).transfer(msg.value);
    }
}
