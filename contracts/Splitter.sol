pragma solidity ^0.4.6;

contract Splitter {

	address public  owner;
	mapping(address => uint) public balances;

	event LogSplit(address sender, address address1, address address2, uint amount);
	event LogWithdraw(address to, uint amount);
	event LogKill(uint blocknumber);

	modifier isOwner()
	{
		require(msg.sender == owner);
		_;
	}

	function Splitter() {
		owner = msg.sender;
	}

	function split(address address1, address address2)
		public
		payable
		returns(bool success)
	{
		require(msg.value > 1);
		require(address1 != address(0));
		require(address2 != address(0));
        uint amount = (msg.value - (msg.value % 2)) / 2;
        balances[address1] += amount;
        balances[address2] += amount;
        balances[msg.sender] += msg.value % 2;
        LogSplit(msg.sender, address1, address2, amount);
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

	function withdraw()
	    public
	    returns(bool success)
	{
	    assert(balances[msg.sender] > 0);
	    uint amount = balances[msg.sender];
	    balances[msg.sender] = 0;
	    msg.sender.transfer(balances[msg.sender]);
	    LogWithdraw(msg.sender, amount);
	    return true;
	}

}
