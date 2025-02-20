// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console } from "forge-std/Test.sol";
import { AccessControlEnumerableExample } from "../../src/access-control/AccessControlEnumerableExample.sol";

contract AccessControlEnumerableTest is Test {
    AccessControlEnumerableExample token;
    address deployer = makeAddr("deployer");
    address user = makeAddr("user");
     address ochuko = makeAddr("ochuko");
     bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
      bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
       bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    function setUp() public {
        vm.prank(deployer); 
        token = new AccessControlEnumerableExample();
    }

    function testGrantMinterRole() public {
        vm.prank(deployer);
        token.grantMinterRole(user);
        
        bool hasMinterRole = token.hasRole(token.MINTER_ROLE(), user);
        assertTrue(hasMinterRole, "User should have MINTER_ROLE");
    }

    function testGrantRole() public {
        vm.startPrank(deployer);
        token.grantRoleToUser(MINTER_ROLE, user);
       
         token.grantRoleToUser(DEFAULT_ADMIN_ROLE, user);
          token.grantRoleToUser(ADMIN_ROLE, user);
         vm.stopPrank();

         vm.prank(user);
          token.grantRoleToUser(DEFAULT_ADMIN_ROLE, ochuko);

         bool hasMinterRole = token.hasRole(token.MINTER_ROLE(), user);
        assertTrue(hasMinterRole, "User should have MINTER_ROLE");
    }

    function testRoleMemberCount() external grantMinters() {
         
       uint256 totalMinters = token.getTotalMinters();
       console.log(totalMinters);
    }

      function testGetRoleMember() external grantMinters() {
       address totalMinters = token.getMinterByIndex(0);
       console.log(totalMinters);
    }

   modifier grantMinters() {
    vm.startPrank(deployer);
    token.grantRoleToUser(MINTER_ROLE, user);
    token.grantRoleToUser(MINTER_ROLE, ochuko);
    vm.stopPrank(); // Stop the prank before proceeding to function execution
    _;
}

}
