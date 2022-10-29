pragma solidity ^0.8.17;

contract NameService{
  struct User{
    string userName;
    string userAddress;
    address owner;
    bool exists;
  }

  mapping (string => User) public nameservice;

  function addUser(string memory userName, string memory userAddress) public returns(bool){
    require(nameservice[userName].exists == false, "Username already exists");
    User memory new_user = User(userName, userAddress, msg.sender, true);
    nameservice[userName] = new_user;
    return true;
  }

  function updateAddress(string memory userName, string memory newUserAddress) public returns(bool){
    require(nameservice[userName].exists == true && nameservice[userName].owner == msg.sender); 
    nameservice[userName].userAddress = newUserAddress;
    return true;
  }

  function lookUpUser(string memory userName) public returns(string memory){
    require(nameservice[userName].exists == true, "No user exists");
    return nameservice[userName].userAddress;
  }
  
  function deleteUser(string memory userName) public returns(bool){
    require(nameservice[userName].exists == true && nameservice[userName].owner == msg.sender); 
    delete nameservice[userName];
    return true;
  }

}
