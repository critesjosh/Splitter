var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter', function(accounts) {

  var contract;
  var owner = accounts[0];
  var initBalance = 100;

  var account1 = accounts[1];
  var account2 = accounts[2];
  var account3 = accounts[3];

  beforeEach(function(){
    return Splitter.new()
    .then(function(instance){
      contract = instance;
    });
  });

  it("should register three people", function(){
    contract.registerMember({from: account1})
    .then(function(bool){
      contract.registerMember({from: account2});
      contract.registerMember({from: account3});
      return contract.Alice({from:owner});
    })
    .then(function(_alice){
      assert.strictEqual(_alice, account1, "alice should have been set to account 1");
      return contract.Bob({from: owner});
    })
    .then(function(_bob){
      assert.strictEqual(_bob, account2, "bob should be account2");
      return contract.Carol({from: owner});
    })
    .then(function(_carol){
      assert.strictEqual(_carol, account3, "carol should be account3");
    })
  });

  it("should receive payments", function(){
    contract.balance.call().then(function(balance){console.log(balance)});

  });

});
