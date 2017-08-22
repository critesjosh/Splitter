var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter', function(accounts) {

  var contract;
  var owner = account0 = accounts[0];
  var initBalance = 100;

  var account1 = accounts[1];
  var account2 = accounts[2];
  var account3 = accounts[3];
  var account4 = accounts[4];
  var account5 = accounts[5];

  beforeEach(function(){
    return Splitter.new()
    .then(function(instance){
      contract = instance;
    });
  });

  it("should register three people", function(){
    // contract.registerBob({from: account1})
    // .then(function(bool){
    //   contract.registerCarol({from: account2});
    //   return contract.Bob({from: owner});
    // })
    // .then(function(_bob){
    //   assert.strictEqual(_bob, account1, "bob should be account1");
    //   return contract.Carol({from: owner});
    // })
    // .then(function(_carol){
    //   assert.strictEqual(_carol, account2, "carol should be account 2");
    //   contract.registerOtherMember({from: account3});
    //   contract.registerOtherMember({from: account4});
    //   contract.registerOtherMember({from: account5});
    //   return contract.getOtherMembers.call();
    // })
    // .then(function(_otherMembers){
    //   assert.strictEqual(_otherMembers[0], account3, "other memeber 0 should be acocunt3");
    //   assert.strictEqual(_otherMembers[1], account4, "other member index 1 should be account4");
    //   assert.strictEqual(_otherMembers[2], account5, "other member index 2 should be account 5");
    // });
  });

  it("should receive and divide payments", function(){
    // contract.registerBob({from: account1});
    // contract.registerCarol({from: account2});
    // contract.splitForBobandCarol({from: owner, value: 100000})
    // .then(function(bool){
    //   return contract.getBalance.call(account1);
    // })
    // .then(function(balance){
    //   assert.equal(balance.toString(10), 50000, "bobs balance should be 50000");
    //   return contract.getBalance.call(account2);
    // })
    // .then(function(balance){
    //   assert.equal(balance.toString(10), 50000, "carols balance should be 50000");
    //   contract.registerOtherMember({from: account3});
    //   contract.registerOtherMember({from: account4});
    //   contract.registerOtherMember({from: account5});
    //   contract.split({from: owner, value: 30000});
    //   return contract.getBalance.call(account3); 
    // })
    // .then(function(balance){
    //   assert.equal(balance.toString(10), 10000, "account3 balance should have been 10000");
    //   return contract.getBalance.call(account4); 
    // })
    // .then(function(balance){
    //   assert.equal(balance.toString(10), 10000, "account4 balance should have been 10000");
    //   return contract.getBalance.call(account5);
    // })
    // .then(function(balance){
    //   assert.equal(balance.toString(10), 10000, "account5 balance should have been 10000");
    //   contract.payoutAllOthers({from: owner});
    //   return contract.getBalance.call(account4);
    // })
    // .then(function(balance){
    //   assert.equal(balance.toString(10), 0, "account4 should have been emptied");
    // });  
  });

});
