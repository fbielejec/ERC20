// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

contract ERC20 {

event Transfer (address indexed, address indexed, uint256);
event Approval (address indexed, address indexed, uint256);

// storage
string  public name;
string  public symbol;
uint8   public decimals;
uint256 public totalSupply;

address private owner;

mapping (address => uint256) public balanceOf;
mapping (address => mapping (address => uint256)) public allowance;

constructor (string memory _name, string memory _symbol, uint8 _decimals) {
   name = _name;
   symbol = _symbol;
   decimals = _decimals;

   owner = msg.sender;
}

function _transferFrom (address from, address to, uint256 amount, address spender) internal returns (bool) {

  // only check allowance if not transferring own tokens
  if (from != spender) {

    uint256 allowed = allowance [from] [spender];

    if (amount > allowed) {
      revert ("insufficient allowance");
    }

    // Don't decrease infinite allowance
    if (allowed != type(uint256).max) {
      allowance[from][spender] -= amount;
    }

  }

  if (amount > balanceOf [from]) {
    revert ("insufficient balance");
  }

  balanceOf [from] -= amount;
  balanceOf [to] += amount;

  emit Transfer (from, to, amount);
  return true;
}

function transferFrom (address from, address to, uint256 amount) external returns (bool) {
  return _transferFrom(from, to, amount, msg.sender);
}

function transfer (address to, uint256 amount ) external returns (bool) {
  return _transferFrom(msg.sender, to, amount, msg.sender);
}

function approve (address spender, uint256 amount) external returns (bool) {
  allowance [msg.sender] [spender] = amount;
  emit Approval (msg.sender, spender, amount);
  return true;
}

function _mint (address to, uint256 amount) internal {

  if (msg.sender != owner) {
    revert ("not an owner address");
  }

  /* // Check for totalSupply overflow */
  /* if (totalSupply + amount < totalSupply) { */
  /*   revert("totalSupply overflow"); */
  /* } */

  /* // Check for balance overflow */
  /* if (balanceOf[to] + amount < balanceOf[to]) { */
  /*   revert("balance overflow"); */
  /* } */

  totalSupply += amount;
  balanceOf [to] += amount;
  emit Transfer (msg.sender, msg.sender, amount);
}

}
