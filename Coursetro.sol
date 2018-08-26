pragma solidity ^0.4.18;

contract Coursetro {
    string fName;
    uint age;

    event Instructor(
        string name,
        uint age
    );

    function Coursetro() public {
    }

    function setInstructor(string _name, uint _age) public {
        fName = _name;
        age = _age;
        Instructor(fName, age);
    }

    function getInstructor() public constant returns (string, uint) {
        return (fName, age);
    }
}
