import "./Destroyable.sol";

pragma solidity 0.5.12;

contract People is Destroyable {
    struct Person {
        uint id;
        string name;
        uint age;
        uint height;
        bool senior;
    }
    
    event PersonCreated(string name, uint age);
    event PersonDeleted(string name, uint age, address deletedBy);
    event PersonUpdated(string name, uint age, uint height, address updatedBy);
    
    uint public balance;
    
    modifier costs(uint cost){
        require(msg.value >= cost);
        _;
    }
    
    mapping(address => bool) private hasCreated;
    mapping(address => Person) internal people; 
    address[] private creators;
    
    function createPerson(string memory name, uint age, uint height) internal costs(100 wei){
        balance += msg.value;
        
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;
        if(age >= 65){
            newPerson.senior = true;
        }
        else {
            newPerson.senior = false;
        }
        
        insertPerson(newPerson);
        hasCreated[msg.sender] = true;
        creators.push(msg.sender);
        assert(
            keccak256(abi.encodePacked(
                people[msg.sender].name, 
                people[msg.sender].age, 
                people[msg.sender].height)
                ) 
                == 
                keccak256(
                    abi.encodePacked(
                        newPerson.name, 
                        newPerson.age, 
                        newPerson.height
                        )
                    )   
                );
        emit PersonCreated(newPerson.name, newPerson.age);
    }
    
    function insertPerson(Person memory newPerson) private {
        address creator = msg.sender;
        people[creator] = newPerson;
    }
    
    function getPerson() public view returns(string memory name, uint age, uint height){
        address creator = msg.sender;
        return (people[creator].name, people[creator].age, people[creator].height);
    }
    
    // helper function to remove a Person from the people mapping 
    function removePerson(address toRemove) internal{
        string memory name = people[toRemove].name;
        uint age = people[toRemove].age;
        delete people[toRemove];
        assert(people[toRemove].age == 0);
        emit PersonDeleted(name, age, msg.sender);    
    }
    
    // only owner function to delete a Person from person mapping
    function deletePerson(address creator) public onlyOwner{
        removePerson(creator);
    }    
    
    function updatePerson(string memory name, uint age, uint height) public{
        require(hasCreated[msg.sender], "this person does not exist.");
        Person memory oldPerson = people[msg.sender];
        Person memory newPerson = people[msg.sender];
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;
        if(age >= 65){
            newPerson.senior = true;
        }
        else {
            newPerson.senior = false;
        }
        
        insertPerson(newPerson);
        assert(
            keccak256(abi.encodePacked(
                newPerson.name, 
                newPerson.age, 
                newPerson.height)
                ) 
                != 
                keccak256(
                    abi.encodePacked(
                        oldPerson.name, 
                        oldPerson.age, 
                        oldPerson.height
                        )
                    )   
                );
        emit PersonUpdated(name, age, height, msg.sender);
    }
    
    function getCreator(uint index) public view onlyOwner returns(address){
        return creators[index];
    }
    
    
}
