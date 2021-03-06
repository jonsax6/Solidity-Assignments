pragma solidity 0.5.12;

contract ERC20 {

    mapping (address => uint256) private _balances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

        constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
        _decimals = 18;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function mint(address account, uint256 amount) public {
        _totalSupply = _totalSupply + amount;
        _balances[account] = _balances[account] + amount;
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(_balances[msg.sender] >= amount);

        _balances[msg.sender] = _balances[msg.sender] - amount;
        _balances[recipient] = _balances[recipient] + amount;

        return true;
    }
}
