// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import { Test, console } from "forge-std/Test.sol";
import { OwnershipControl } from "../../src/ownership-control/OwnershipControl.sol";

contract OwnershipControlTest is Test {

    address owner = makeAddr("owner");
    address ochuko = makeAddr("ochuko");
    address user = makeAddr("user");

    OwnershipControl ownershipControl;

    function setUp() public {
        vm.prank(owner);
        ownershipControl = new OwnershipControl(owner);
    }

    function testOwnerHasPrivileges() external {
        vm.prank(owner);
        bool checkDeployer = ownershipControl.checkIfIsDeployer("OGHENEOCHUKO");
        assert(checkDeployer == true);
    }

     function testUserDoesNotPrivileges() external {
        vm.prank(user);
        vm.expectRevert();
        ownershipControl.checkIfIsDeployer("OGHENEOCHUKO");
       
    }

    function testRenounceOwnership() external {
        vm.prank(owner);
        // ownershipControl.renounceOwnership();
        ownershipControl.renounceOwnershipClaim();
         vm.expectRevert();
        vm.prank(owner);
        ownershipControl.checkIfIsDeployer("OGHENEOCHUKO");
       
    }

    function testTransferOwnership() external {
        vm.prank(owner);
        // ownershipControl.transferOwnership(ochuko);
        ownershipControl.transferOwnershipClaim(ochuko);
         vm.expectRevert();
        vm.prank(owner);
        ownershipControl.checkIfIsDeployer("OGHENEOCHUKO");
    }

}