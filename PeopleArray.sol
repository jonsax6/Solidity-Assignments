pragma solidity 0.5.12;

contract HelloWorld {
    struct Person {
        uint id;
        address account;
        string name;
        uint age;
        uint height;
    }
    
    Person[] public people;
    
    mapping(address => uint) public totPeople; 
    
    function createPerson(string memory name, uint age, uint height) public{
        address acct = msg.sender;
        people.push(Person(people.length, acct, name, age, height));
        totPeople[acct] = totPeople[acct]+1;
    }
}