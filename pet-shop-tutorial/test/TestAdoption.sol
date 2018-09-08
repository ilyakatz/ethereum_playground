pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";
import "./support/ThrowProxy.sol";

contract TestAdoption {
  Adoption adoption = Adoption(DeployedAddresses.Adoption());

  // Testing the adopt() function
  function testUserCanAdoptPet() public {
    uint returnedId = adoption.adopt(8);

    uint expected = 8;

    Assert.equal(returnedId, expected, "Adoption of pet ID 8 should be recorded.");
  }

  // Testing retrieval of a single pet's owner
  function testGetAdopterAddressByPetId() public {
    // Expected owner is this contract
    address expected = this;

    address adopter = adoption.adopters(8);

    Assert.equal(adopter, expected, "Owner of pet ID 8 should be recorded.");
  }

  // Testing retrieval of all pet owners
  function testGetAdopterAddressByPetIdInArray() public {
    // Expected owner is this contract
    address expected = this;

    // Store adopters in memory rather than contract's storage
    address[16] memory adopters = adoption.getAdopters();

    Assert.equal(adopters[8], expected, "Owner of pet ID 8 should be recorded.");
  }

  function testGiveAwayPet() public {
    address expected = adoption.getOwner() ;
    adoption.adopt(8);
    address a = adoption.adopters(8);

    Assert.notEqual(a, expected, "Pet 8 should not be owned by shelter");

    adoption.giveAway(8);
    address adopter = adoption.adopters(8);
    Assert.equal(adopter, expected, "Pet 8 should have been returned to shelter");
  }

  function testGiveAwayOnlyYourPet() public {
    address expected = adoption.getOwner() ;
    adoption.adopt(8);
    adoption.giveAway(8);
    address adopter = adoption.adopters(8);
    Assert.equal(adopter, expected, "Pet 8 should have been returned to shelter");
  }

  function testGiveAwayPetThatIsNotYours() public {
    Adoption thrower = Adoption(DeployedAddresses.Adoption());
    ThrowProxy throwProxy = new ThrowProxy(address(thrower));

    //prime the proxy.
    Adoption(address(throwProxy)).giveAway(8);

    bool r = throwProxy.execute.gas(200000)();

    Assert.isFalse(r, "Should throw exception");
  }
}