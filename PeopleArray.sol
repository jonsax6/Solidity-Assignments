pragma solidity 0.5.12;

//create contract
contract HelloWorld {
        
    //create Person struct
    struct Person {
        uint id;
        address creator;
        string name;
        uint age;
        uint height;
    }
    
    //create Person array
    Person[] public people;
    
    //create addres to integer mapping. Counts the number of people at all addresses
    mapping(address => uint) public totalPeople;
    
    //createPerson function
    function createPerson(string memory name, uint age, uint height) public{
        //ethereum address of the current contract user
        address account = msg.sender;
        //adds one Person into the person array with user provided data
        people.push(Person(people.length, account, name, age, height));
        //maps one Person count to the totalPeople mapping for msg.sender address
        totalPeople[account]++;
    }
    
    //IDarray function public view returns an array of number of people at msg.sender from temporary array
    function IDarray() public view returns(uint[] memory pplArray){
        //declare new array of length (number of people at msg.sender)        
        pplArray = new uint[](totalPeople[msg.sender]);
        //declare index counter uint index
        uint index = 0;
        //for loop which checks each index of people array to see if the address equals creator address
        for(uint i = 0; i < people.length; i++){
            //if statement checking to see if address at people array equals creator address
            if(people[i].creator == msg.sender){
                //if matches add people[i].id to pplArray[index]
                pplArray[index] = people[i].id;
                //index +1
                index++;
            }
        }
    }
}
