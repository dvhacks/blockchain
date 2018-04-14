const SaveShip = artifacts.require("./SaveShip.sol");

contract('SaveShip', function(accounts) {
  it("should set created state in constructor", function() {
    return SaveShip.deployed().then(function(instance) {
      return instance.state.call();
    }).then(function(result) {
      assert.equal(result.valueOf(), 0, "State was not 0");
    });
  });
  it("should set sender in constructor", function() {
    return SaveShip.deployed().then(function(instance) {
      return instance.sender.call();
    }).then(function(result) {
      assert.equal(result.valueOf(), '0xbca1c0906199152c60dd45a5e87e0f7c343c85a8', "Sender was not as expected");
    });
  });
  it("should set cost in constructor", function() {
    return SaveShip.deployed().then(function(instance) {
      return instance.cost.call();
    }).then(function(result) {
      assert.equal(result.valueOf(), 42, "Cost was not 42");
    });
  });
});
