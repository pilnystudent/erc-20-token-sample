// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "./IERC20.sol";

contract CZKC is IERC20{
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint private _totalSupply;

    mapping(address => uint) private _balances;
    mapping(address => mapping(address => uint)) private _allowances;

    constructor() {
        _name = "CZK Coin";
        _symbol = "CZKC";
        _decimals = 18;
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function decimals() external view returns (uint8) {
        return _decimals;
    }

    function totalSupply() external view returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint) {
        return _balances[account];
    }

    function allowance(address owner, address spender) external view returns (uint){
        return _allowances[owner][spender];
    }

    function transfer(address to, uint amount) external returns (bool) {
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool){
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address spender, address recipient, uint amount) external returns (bool){
        _allowances[spender][msg.sender] -= amount;
        _balances[spender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(spender, recipient, amount);
        return true;
    }

    function mint(address recipient, uint amount) external returns(bool){
        _totalSupply += amount;
        _balances[recipient] += amount;
        emit Transfer(address(0), recipient, amount);
        return true;
    }

    function burn(uint amount) external returns(bool){
        _totalSupply -= amount;
        _balances[msg.sender] -= amount;
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
