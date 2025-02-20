// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import { Test, console } from "forge-std/Test.sol";
import { OwnershipControl2Step } from "../../src/ownership-control/OwnershipControl2Step.sol";

contract OwnershipControl2StepTest is Test {

    address owner = makeAddr("owner");
    address ochuko = makeAddr("ochuko");
    address user = makeAddr("user");

    OwnershipControl2Step ownershipControl;

    function setUp() public {
        vm.prank(owner);
        ownershipControl = new OwnershipControl2Step(owner);
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
        vm.prank(ochuko);
        ownershipControl.acceptOwnershipClaim();
         vm.expectRevert();
        vm.prank(owner);
        ownershipControl.checkIfIsDeployer("OGHENEOCHUKO");
    }

}