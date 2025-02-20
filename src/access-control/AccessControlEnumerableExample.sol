// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { AccessControlEnumerable} from "@openzeppelin/contracts/access/extensions/AccessControlEnumerable.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AccessControlEnumerableExample is ERC20, AccessControlEnumerable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
       bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
     bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");


    constructor() ERC20("TestToken", "TTK") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender); // Grant the deployer admin rights
         _grantRole(ADMIN_ROLE, msg.sender);
    }

    function grantMinterRole(address account) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(MINTER_ROLE, account);
    }

    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function getTotalMinters() external view returns (uint256) {
        return getRoleMemberCount(MINTER_ROLE);
    }

     function getMinterByIndex(uint256 index) external view returns (address) {
        return getRoleMember(MINTER_ROLE, index);
    }
    function burn(address from, uint256 amount) public onlyRole(BURNER_ROLE) {
        _burn(from, amount);
    }

   function grantRoleToUser(bytes32 role,address to) external onlyRole(DEFAULT_ADMIN_ROLE){
       grantRole(role, to);
   }

   function userRenounceRole(bytes32 role, address user) external {
    renounceRole(role, user);
   }

   function checkUserHasRole(bytes32 role, address user) view external returns (bool status) {
    status = hasRole(role, user);
   }

   function userGetRoleAdmin(bytes32 role) external view returns(bytes32 roleAdmin) {
    roleAdmin = getRoleAdmin(role);
   }

   function adminRevokeRole(bytes32 role, address user) external onlyRole(ADMIN_ROLE){
    revokeRole(role, user);
   }
}
