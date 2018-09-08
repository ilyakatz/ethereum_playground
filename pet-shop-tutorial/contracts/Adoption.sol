pragma solidity ^0.4.22;


contract Adoption {
  address[16] public adopters;
  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  // Adopting a pet
  function adopt(uint petId) public returns (uint) {
    require(petId >= 0 && petId <= 15);

    adopters[petId] = msg.sender;

    return petId;
  }

  function giveAway(uint petId) public {
    require(petId >= 0 && petId <= 15);
    require(adopters[petId] == msg.sender, "Can only give away pet owned by you");

    adopters[petId] = owner;
  }

  // Retrieving the adopters
  function getAdopters() public view returns (address[16]) {
    return adopters;
  }

  function getOwner() public view returns (address) {
    return owner;
  }
}