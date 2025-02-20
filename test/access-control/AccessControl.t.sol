// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import { Test, console } from "forge-std/Test.sol";
import { AccessControlERC20MintBase } from "../../src/access-control/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract OwnershipControlTest is Test {

    address owner = makeAddr("owner");
     address deployer = makeAddr("deployer");
    address ochuko = makeAddr("ochuko");
    address user = makeAddr("user");

    AccessControlERC20MintBase accessControl;

  function setUp() public {
    vm.startPrank(deployer);
    accessControl = new AccessControlERC20MintBase();
    vm.stopPrank();
}
    function testUnauthorizedUsers() public {
        vm.expectRevert();
        vm.prank(deployer);
        accessControl.mint(deployer, 5);
    }

    function testGrantRole() external {
        uint256 amountToMint = 5;
        vm.prank(deployer);
        accessControl.grantRoleToUser(accessControl.MINTER_ROLE(), user);
        // accessControl.mint(user, amountToMint);
        // uint256 userBalance = IERC20(address(accessControl)).balanceOf(user);
        // console.log("User balance", userBalance);
        // assertEq(userBalance, amountToMint);
    }

    function testCheckUserHasRole() external {
        console.log(address(this));
        console.log(deployer);
        vm.prank(deployer);

       bool adminRole = accessControl.checkUserHasRole(accessControl.ADMIN_ROLE(), deployer);
        bool defaultAdminRole = accessControl.checkUserHasRole(accessControl.DEFAULT_ADMIN_ROLE(), deployer);

        console.log("Default admin role", defaultAdminRole);
        console.log("Admin role", adminRole);
    }

    function testGetRoleAdmin () external {
        vm.prank(user);
       bytes32 adminRole = accessControl.userGetRoleAdmin(accessControl.ADMIN_ROLE());
       bytes32 minterRole = accessControl.userGetRoleAdmin(accessControl.MINTER_ROLE());
       assertEq(adminRole, minterRole);
       assertEq(adminRole, accessControl.DEFAULT_ADMIN_ROLE());
    }

    function testUserRenounceRole() external {
        vm.prank(deployer);
        accessControl.userRenounceRole(accessControl.ADMIN_ROLE(), deployer);

         bool adminRole = accessControl.checkUserHasRole(accessControl.ADMIN_ROLE(), deployer);
         console.log("Admin role", adminRole);
    }

 
}