// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;

import "./ERC20.sol";

contract MBT is ERC20{

    constructor() {
        name = "Mintable Burnable Token";
        symbol = "MBT";
        decimals = 18;
        owner = msg.sender;
    }

    function mint(address recipient, uint amount) external returns(bool) {
        require(owner == msg.sender);
        totalSupply += amount;
        balanceOf[recipient] += amount;
        emit Transfer(address(0), recipient, amount);
        return true;
    }

    function burn(uint amount) external returns(bool) {
        totalSupply -= amount;
        balanceOf[msg.sender] -= amount;
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
