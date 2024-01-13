// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract ERC20Token {
    // Address of the contract owner
    address public owner;

    // Name of the token
    string public name;

    // Symbol of the token
    string public symbol;

    // Decimals for token precision
    uint8 public decimals;

    // Total supply of tokens
    uint256 public totalSupply;

    // Mapping to track token balances for each address
    mapping(address => uint256) public balanceOf;

    // Mapping to track approved spending allowances
    mapping(address => mapping(address => uint256)) public allowance;

    // Event emitted on token transfer
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Event emitted on approval of spending allowance
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "ERC20Token: Only the contract owner can call this function"
        );
        _;
    }

    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        uint8 decimalUnits,
        uint256 initialSupply
    ) {
        owner = msg.sender;
        name = tokenName;
        symbol = tokenSymbol;
        decimals = decimalUnits;
        totalSupply = initialSupply * (10 ** uint8(decimals));
        balanceOf[msg.sender] = totalSupply;
    }

    /**
     * @dev Transfer tokens from sender's account to a specified address.
     * @param to The address to which tokens will be transferred.
     * @param amount The amount of tokens to be transferred.
     */
    function transfer(
        address to,
        uint256 amount
    ) public returns (bool success) {
        require(to != address(0), "ERC20Token: Transfer to the zero address");
        require(
            balanceOf[msg.sender] >= amount,
            "ERC20Token: Insufficient balance"
        );
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    /**
     * @dev Approve spending of tokens by another address.
     * @param spender The address allowed to spend tokens.
     * @param amount The amount of tokens allowed to be spent.
     */
    function approve(
        address spender,
        uint256 amount
    ) public returns (bool success) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * @dev Transfer tokens from one address to another using an allowance.
     * @param from The address from which tokens will be transferred.
     * @param to The address to which tokens will be transferred.
     * @param amount The amount of tokens to be transferred.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool success) {
        require(
            amount <= allowance[from][msg.sender],
            "ERC20Token: Transfer amount exceeds allowance"
        );
        require(
            amount <= balanceOf[from],
            "ERC20Token: Transfer amount exceeds balance"
        );
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Increase the allowance granted to a spender for spending tokens on behalf of the owner.
     * @param spender The address authorized to spend the tokens.
     * @param addedValue The additional amount of tokens approved for spending.
     */
    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public returns (bool success) {
        allowance[msg.sender][spender] += addedValue;
        emit Approval(msg.sender, spender, allowance[msg.sender][spender]);
        return true;
    }

    /**
     * @dev Decrease the allowance granted to a spender for spending tokens on behalf of the owner.
     * @param spender The address authorized to spend the tokens.
     * @param subtractedValue The amount of tokens to be subtracted from the allowance.
     */
    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public returns (bool success) {
        require(
            allowance[msg.sender][spender] >= subtractedValue,
            "ERC20Token: Decreased allowance below zero"
        );
        allowance[msg.sender][spender] -= subtractedValue;
        emit Approval(msg.sender, spender, allowance[msg.sender][spender]);
        return true;
    }

    /**
     * @dev Mint new tokens and assign them to the specified address.
     * Only accessible by the contract owner.
     * @param account The address to which new tokens will be minted.
     * @param amount The amount of tokens to be minted.
     */
    function mint(address account, uint256 amount) public onlyOwner {
        totalSupply += amount;
        balanceOf[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Burn tokens from a specific address.
     * Only accessible by the contract owner.
     * @param account The address from which tokens will be burned.
     * @param amount The amount of tokens to be burned.
     */
    function burn(address account, uint256 amount) public onlyOwner {
        require(
            amount <= balanceOf[account],
            "ERC20Token: Burn amount exceeds balance"
        );
        totalSupply -= amount;
        balanceOf[account] -= amount;
        emit Transfer(account, address(0), amount);
    }
}
