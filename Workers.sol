import "./Ownable.sol";

// Should inherit from the People Contract. 
import "./People.sol";

pragma solidity 0.5.12;

contract Workers is Ownable, People{
    // add mapping called salary which maps an address to an integer. 
    mapping(address => uint) private annSalary;
    // For the address of each worker created, map the address of the employer
    mapping(address => address) private employer;
    
    event PersonFired(string name, uint age, address FiredBy);

    
    modifier costs(uint cost){
        require(msg.value >= cost);
        _;
    }

    // createWorker function which is a wrapper function for the createPerson function.   
    // make the correct visibility level for the createPerson function (internal). 
    function createWorker(string memory name, uint age, uint height, uint salary, address boss) public payable costs(100 wei){
        // persons age should not be allowed to be over 75. 
        require(age <= 75);
        // worker is not allowed to be his/her own boss. 
        require(msg.sender != boss);
        //reference createPerson function in People contract
        createPerson(name, age, height);
        // set the salary for the Worker in the new mapping.
        annSalary[msg.sender] = salary;
        // For the address of each worker created, map the address of the employer
        employer[msg.sender] = boss;
    }
    // Implement a fire function, which removes the worker from the contract.
    function fireWorker(address terminated) public {
        // Make sure that a worker can only be fired by his/her boss.
        require(msg.sender == employer[terminated]);
        string memory name = people[terminated].name;
        uint age = people[terminated].age;
        delete people[terminated];
        // By implementing a new function in the base contract, used by both deletePerson and fire, make sure there is as little code 
        // duplication as possible between the deletePerson function and the fire function. 
        verifyRemoved(name, age, terminated);
    }
}

