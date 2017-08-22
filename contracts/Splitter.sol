pragma solidity ^0.4.6;

contract Splitter {

	address public  owner;
	address private address1;
	address private address2;
	mapping(address => uint) public balances;

	event LogSplit(uint amount);
	event LogCashOut(address to, uint amount);
	event LogDesposit(address from, uint amount);
	event LogKill(uint blocknumber);

	modifier isOwner()
	{
		require(msg.sender == owner);
		_;
	}

	function Splitter(address _address1, address _address2) {
		require(_address1 != address(0));
		require(_address2 != address(0));
		address1 = _address1;
		address2 = _address2;
		owner = msg.sender;
	}

	function split()
		public
		payable
		isOwner
		returns(bool success)
	{
		require(msg.value > 1);
		bool odd = msg.value % 2 == 1;
        uint amount = odd ? (msg.value - 1) / 2 : msg.value / 2;
        balances[address1] += amount;
        balances[address2] += amount;
        LogSplit(amount);
        if(odd) {msg.sender.transfer(1);}
		return true;
	}

	function kill()
		public
		isOwner
		returns(bool success)
	{
		LogKill(block.number);
		selfdestruct(owner);
		return true;
	}

	function cashMeOut()
	    public
	    returns(bool success)
	{
	    assert(balances[msg.sender] > 0);
	    uint amount = balances[msg.sender];
	    balances[msg.sender] = 0;
	    if(!msg.sender.send(amount)){
	    	balances[msg.sender] = amount;
	    	throw;
	    }
	    LogCashOut(msg.sender, amount);
	    return true;
	}

	function()
		payable
		public
	{
		LogDesposit(msg.sender, msg.value);
	}

}
