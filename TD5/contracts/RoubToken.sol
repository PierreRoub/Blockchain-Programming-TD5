pragma solidity ^0.4.25;


import "./IERC20.sol";
import "../math/SafeMath.sol";

contract ERC20 is IERC20 {
    using SafeMath for uint256;
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowed;
    uint256 private _totalSupply;

    string public name;                   
    uint8 public decimals;                
    string public symbol;                 
    string public version = "H1.0";

    constructor() public {
        _totalSupply = 1000000001; 
        _balances[0x6059834065bC63B286708bE7cC136953cf1724FB] = _totalSupply-1;                               
        name = "RoubToken";                                   
        decimals = 0;                            
        symbol = "RBT";                               
        _balances[0x6059834065bC63B286708bE7cC136953cf1724FB] = _totalSupply-1;
    }

    // Total number of tokens in existence
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }


    // Gets the balance of the specified address.
    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }


    // Function to check the amount of tokens that an owner allowed to a spender.
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
    }


    // Transfer token to a specified address
    function transfer(address to, uint256 value) public returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }


    // Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
    // Beware that changing an allowance with this method brings the risk that someone may use both the old
    // and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
    // race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }


    // Transfer tokens from one address to another.
    // Note that while this function emits an Approval event, this is not required as per the specification,
    // and other compliant implementations may not emit the event.
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        _transfer(from, to, value);
        _approve(from, msg.sender, _allowed[from][msg.sender].sub(value));
        return true;
    }


    // Increase the amount of tokens that an owner allowed to a spender.
    // approve should be called when _allowed[msg.sender][spender] == 0. To increment
    // allowed value is better to use this function to avoid 2 calls (and wait until
    // the first transaction is mined)
    // From MonolithDAO Token.sol
    // Emits an Approval event.
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowed[msg.sender][spender].add(addedValue));
        return true;
    }


    // Decrease the amount of tokens that an owner allowed to a spender.
    // approve should be called when _allowed[msg.sender][spender] == 0. To decrement
    // allowed value is better to use this function to avoid 2 calls (and wait until
    // the first transaction is mined)
    // From MonolithDAO Token.sol
    // Emits an Approval event.
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowed[msg.sender][spender].sub(subtractedValue));
        return true;
    }

    // Transfer token for a specified addresses
    function _transfer(address from, address to, uint256 value) internal {
        require(to != address(0));

        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
        emit Transfer(from, to, value);
    }

    // Internal function that mints an amount of the token and assigns it to
    // an account. This encapsulates the modification of balances such that the
    // proper events are emitted.
    function _mint(address account, uint256 value) internal {
        require(account != address(0));

        _totalSupply = _totalSupply.add(value);
        _balances[account] = _balances[account].add(value);
        emit Transfer(address(0), account, value);
    }

    // Internal function that burns an amount of the token of a given
    // account.
    function _burn(address account, uint256 value) internal {
        require(account != address(0));

        _totalSupply = _totalSupply.sub(value);
        _balances[account] = _balances[account].sub(value);
        emit Transfer(account, address(0), value);
    }

    // Approve an address to spend another addresses' tokens.
    function _approve(address owner, address spender, uint256 value) internal {
        require(spender != address(0));
        require(owner != address(0));

        _allowed[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    // Internal function that burns an amount of the token of a given
    // account, deducting from the sender's allowance for said account. Uses the
    // internal burn function.
    // Emits an Approval event (reflecting the reduced allowance).
    function _burnFrom(address account, uint256 value) internal {
        _burn(account, value);
        _approve(account, msg.sender, _allowed[account][msg.sender].sub(value));
    }
}
    




