import "./Ownable.sol";

pragma solidity 0.5.12;
    
contract Destroyable is Ownable {
    function destroy() public onlyOwner { //onlyOwner is a modifier from Ownable
        selfdestruct(owner);  // `owner` is the owners address imported from Ownable
    }
}    
