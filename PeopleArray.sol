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
    
    function addAccounts(address ethAddress, Person[] memory ppl) private returns(uint) {
        uint i;
        uint numPeople = 0;     //variable to hold the number of people at given address
        for(i = 0; i < ppl.length; i++){
            if (ethAddress == ppl[i].account){
                numPeople++;
            }
        }
        return numPeople;
    }
    
    function createPerson(string memory name, uint age, uint height) public{
        address acct = msg.sender;
        people.push(Person(people.length, acct, name, age, height));
        totPeople[acct] = addAccounts(acct, people);
    }
}