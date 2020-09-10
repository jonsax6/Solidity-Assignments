import "./Ownable.sol";

// Should inherit from the People Contract. 
import "./People.sol";

pragma solidity 0.5.12;

contract Workers is Ownable, People{
    // Should extend the People contract by adding another mapping called salary which maps an address to an integer. 
    mapping(address => uint) private annSalary;
    // For each worker created, you need to input and save information about who (which address) is the boss. 
    // This should be implemented in the Worker contract.
    mapping(address => address) private employer;
    
    event PersonFired(string name, uint age, address FiredBy);

    
    modifier costs(uint cost){
        require(msg.value >= cost);
        _;
    }

    // Have a createWorker function which is a wrapper function for the createPerson function. Make sure to figure out 
    // the correct visibility level for the createPerson function (it should no longer be public). This is the only modification 
    // we should do in the People contract.
    function createWorker(string memory name, uint age, uint height, uint salary, address boss) public payable costs(100 wei){
        // When creating a worker, the persons age should not be allowed to be over 75. 
        require(age <= 75);
        // A worker is not allowed to be his/her own boss. 
        require(msg.sender != boss);
        createPerson(name, age, height);
        // Apart from calling the createPerson function, the createWorker function should also set the salary for the Worker in the 
        // new mapping.
        annSalary[msg.sender] = salary;
        employer[msg.sender] = boss;
    }
    // Implement a fire function, which removes the worker from the contract.
    function fireWorker(address terminated) public {
        // Make sure that a worker can only be fired by his/her boss.
        require(msg.sender == employer[terminated]);
        string memory name = people[terminated].name;
        uint age = people[terminated].age;
        deletePerson(terminated);
        // By implementing a new function in the base contract, used by both deletePerson and fire, make sure there is as little code 
        // duplication as possible between the deletePerson function and the fire function. 
        verifyRemoved(name, age, terminated);
    }
}

