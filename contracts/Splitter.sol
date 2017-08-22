pragma solidity ^0.4.6;

contract Splitter {

	address   public owner;
	mapping(address => uint) public balances;

	event LogSplit(address to1, address to2, address from, uint amount);
	event LogCashOut(address to, uint amount);
	event LogKill(uint blocknumber);

	modifier isOwner()
	{
		require(msg.sender == owner);
		_;
	}

	function Splitter() {
		owner = msg.sender;
	}

	function getBalance(address _address)
		public
		returns(uint)
	{
		return balances[_address];
	}

	function split(address address1, address address2)
		public
		payable
		returns(bool success)
	{
		require(msg.value > 1);
		bool odd = msg.value % 2 == 1;
        uint amount = odd ? (msg.value - 1) / 2 : msg.value / 2;
        balances[address1] += amount;
        balances[address2] += amount;
        LogSplit(address1, address2, msg.sender, amount);
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
	    require(balances[msg.sender] > 0);
	    balances[msg.sender] = 0;
	    msg.sender.transfer(balances[msg.sender]);
	    LogCashOut(msg.sender, balances[msg.sender]);
	    return true;
	}

	function()
		payable
		public
	{
		balances[this] += msg.value;
	}

}
