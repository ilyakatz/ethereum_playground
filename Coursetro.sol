pragma solidity ^0.4.18;

contract Coursetro {
    string fName;
    uint age;
    
    function Coursetro() public {
    }
    
    function setInstructor(string _name, uint _age) public {
        fName = _name;
        age = _age;
    }
    
    function getInstructor() public constant returns (string, uint) {
        return (fName, age);
    }
}
