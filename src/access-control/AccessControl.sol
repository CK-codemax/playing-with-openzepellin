// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AccessControlERC20MintBase is ERC20, AccessControl {
    // Create a new role identifier for the minter role
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
     bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
     bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    error CallerNotMinter(address caller);

   constructor() ERC20("MyToken", "TKN") {
    // Use _grantRole instead of grantRole to set up initial roles
    _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    _grantRole(ADMIN_ROLE, msg.sender);
    _grantRole(MINTER_ROLE, msg.sender);
     _grantRole(BURNER_ROLE, msg.sender);
}

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyRole(BURNER_ROLE) {
        _burn(from, amount);
    }

   function grantRoleToUser(bytes32 role,address to) external onlyRole(MINTER_ROLE){
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