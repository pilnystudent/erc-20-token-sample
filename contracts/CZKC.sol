// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "./IERC20.sol";

contract CZKC is IERC20{
    string public name;
    string public symbol;
    uint8 public decimals;
    uint public totalSupply;

    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    constructor() {
        name = "CZK Coin";
        symbol = "CZKC";
        decimals = 18;
    }

    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address spender, address recipient, uint amount) external returns (bool){
        allowance[spender][msg.sender] -= amount;
        balanceOf[spender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(spender, recipient, amount);
        return true;
    }

    function mint(address recipient, uint amount) external returns(bool){
        totalSupply += amount;
        balanceOf[recipient] += amount;
        emit Transfer(address(0), recipient, amount);
        return true;
    }

    function burn(uint amount) external returns(bool){
        totalSupply -= amount;
        balanceOf[msg.sender] -= amount;
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
