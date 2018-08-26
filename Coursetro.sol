pragma solidity ^0.4.18;

contract Coursetro {
    string fName;
    uint age;
    address owner;

    event Instructor(
        string name,
        uint age
    );

    function Coursetro() public {
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    function setInstructor(string _name, uint _age) onlyOwner public {
        fName = _name;
        age = _age;
        Instructor(fName, age);
    }

    function getInstructor() public constant returns (string, uint) {
        return (fName, age);
    }
}
