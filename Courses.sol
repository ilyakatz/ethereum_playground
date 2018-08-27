pragma solidity ^0.4.18;

contract Owned {
    address owner;

    function Owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
}

contract Courses is Owned {
    struct Instructor {
        uint age;
        bytes16 fName;
        bytes16 lName;
    }

    event instructorInfo(
        bytes16 fName,
        bytes16 lName,
        uint age
    );

    mapping (address => Instructor) instructors;

    address[] public instructorAccounts;

    function setInstructor(address _address, uint _age, bytes16 _fname, bytes16 _lname) onlyOwner public {
        var instructor = instructors[_address];
        instructor.age = _age;
        instructor.fName = _fname;
        instructor.lName = _lname;

        instructorAccounts.push(_address) -1;
        instructorInfo(_fname, _lname, _age);
    }

    function getInstructors() view public returns (address[]) {
        return instructorAccounts;
    }

    function getInstructor(address _address) view public returns(uint, bytes16, bytes16){
        return (
            instructors[_address].age,
            instructors[_address].fName,
            instructors[_address].lName
        );
    }

    function countInstructors() view public returns(uint) {
        return instructorAccounts.length;
    }
}
