// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable2Step.sol";


contract OwnershipControl2Step is Ownable2Step {
    error OwnershipControl2Step__Zero_Address(string message);

    bytes32 private constant DEPLOYER_NAME = keccak256(abi.encode("OGHENEOCHUKO"));
    uint256 private immutable FIRST_DEPLOYED; 
    constructor(address initialOwner) Ownable(initialOwner) {
        FIRST_DEPLOYED = block.timestamp;
    }

   function checkIfIsDeployer(string memory name) public view onlyOwner returns(bool status){
     status = keccak256(abi.encode(name)) == DEPLOYER_NAME;
   }

   function checkFirstDeployed() external view onlyOwner returns(uint256 time){
    time = FIRST_DEPLOYED;
   }

   function renounceOwnershipClaim() external onlyOwner{
    renounceOwnership();
   }

   function transferOwnershipClaim(address newOwner) external onlyOwner{
    if(newOwner == address(0)){
        revert OwnershipControl2Step__Zero_Address("Zero addresses cannot become new owner");
    }
    transferOwnership(newOwner);
   }

   function acceptOwnershipClaim() external {
    acceptOwnership();
   }
}