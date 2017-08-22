pragma solidity ^0.4.6;

contract Splitter {

	address   public owner;
	address   public Bob;
	address   public Carol;
	address[] public otherMembers;
	bool      public active;
	
	mapping(address => uint) public balances;

	event LogBobRegistered(address bobsAddress);
	event LogCarolRegistered(address carolssAddress);
	event LogOtherMemeberRegistered(address othersAddress);
	event LogFundsToBobandCarol(uint amount);
	event LogFundsToOthers(address to, address from, uint amount);
	event LogPayouts(address to, uint amount);

	modifier isActive()
	{
		require(active);
		_;
	}

	modifier isOwner()
	{
		require(msg.sender == owner);
		_;
	}

	function Splitter() {
		owner = msg.sender;
		active = true;
	}

	function getOtherMembers()
		public
		isActive
		returns(address[])
	{
		return otherMembers;
	}

	function getBalance(address _address)
		public
		isActive
		returns(uint)
	{
		return balances[_address];
	}
	
	function registerBob()
	    public
	    returns(bool success)
    {
        require(Bob == address(0));
        Bob = msg.sender;
        LogBobRegistered(msg.sender);
        return true;
    }
    
    function registerCarol()
	    public
	    returns(bool success)
    {
        require(Carol == address(0));
        Carol = msg.sender;
        LogCarolRegistered(msg.sender);
        return true;
    }
    
	function registerOtherMember()
		public
		isActive
		returns(bool success)
	{
        for(uint i=0; i<otherMembers.length;i++){
            if(otherMembers[i] == msg.sender) revert();
        }
        otherMembers.push(msg.sender);
        LogOtherMemeberRegistered(msg.sender);
		return true;
	}
	
	function splitForBobandCarol()
	    public
	    payable
	    isActive
	    isOwner
	    returns(bool success)
	{
		require(msg.value > 0);
		require(Bob != address(0) && Carol != address(0));
		uint amount = msg.value / 2;
		balances[Bob] += amount;
		balances[Carol] += amount;
		LogFundsToBobandCarol(amount);
		return true;
	}
	
	function payoutBobandCarol()
	    public
	    returns(bool success)
	{
	    require(Bob == msg.sender || Carol == msg.sender || owner == msg.sender);
	    require(balances[Bob] > 0);
	    Bob.transfer(balances[Bob]);
	    LogPayouts(Bob, balances[Bob]);
	    balances[Bob] = 0;
	    Carol.transfer(balances[Carol]);
	    LogPayouts(Carol, balances[Carol]);
	    balances[Carol] = 0;
	    return true;
	}

	function split()
		public
		payable
		isActive
		returns(bool success)
	{
		require(msg.value > 0);
        require(otherMembers.length > 0);
		uint amount = msg.value / otherMembers.length;
        for(uint i = 0;i<otherMembers.length; i++){
            balances[otherMembers[i]] += amount;
            LogFundsToOthers(otherMembers[i], msg.sender, amount);
        }
		return true;
	}

	function kill()
		public
		isActive
		isOwner
		returns(bool success)
	{
		payoutBobandCarol();
	    payoutAllOthers();
		selfdestruct(owner);
		return true;
	}
	
	function deposit()
	    public
	    payable
	    isActive
	    returns(bool success)
	{
	    split();
	    return true;      
	}
	
	function payoutAllOthers()
	    public
	    isActive
	    isOwner
	    returns(bool success)
	{
	    require(otherMembers.length > 0);
	    for(uint i=0; i<otherMembers.length; i++) {
	        if(balances[otherMembers[i]] > 0){
	            otherMembers[i].transfer(balances[otherMembers[i]]);
	            balances[otherMembers[i]] = 0;
	            LogPayouts(otherMembers[i], balances[otherMembers[i]]);
	        }
	    }
	    return true;
	}

}
