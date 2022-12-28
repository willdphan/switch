// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "node_modules/forge-std/src/Test.sol";
import "src/Switch.sol";

contract CounterTest is Test {
    Switch public switchContract;
    
    address NFTReceiver = vm.addr(111);

    function setUp() public {
        switchContract = new Switch(2);
        vm.label(NFTReceiver, "RECEIVE");
    }

    function testCheckUpKeep () public {
        vm.warp(3);
        switchContract.checkUpkeep();
    }

    function testFailCheckUpKeep () public {
        vm.warp(1);
        vm.expectRevert();
        switchContract.checkUpkeep();
    }

    function testSafeMint () public {
       switchContract.safeMint(NFTReceiver);
    }

    function testGrowFlower () public {
        switchContract.safeMint(NFTReceiver);
        switchContract.growFlower(0);
    }

    function testFlowerStage () public {
        switchContract.safeMint(NFTReceiver);
        switchContract.growFlower(0);
        assertEq(switchContract.flowerStage(0),1);

        switchContract.growFlower(0);
        assertEq(switchContract.flowerStage(0),2);

        switchContract.growFlower(0);
        assertEq(switchContract.flowerStage(0),2);
    }
   

    function testCompareStrings () public {
        assertEq(switchContract.compareStrings("Test", "Test"), true);
    }

    function testFailCompareStrings () public {
        vm.expectRevert();
        switchContract.compareStrings("Test", "Testing");
    }

    function testTokenURI () public {
        switchContract.safeMint(NFTReceiver);
        switchContract.tokenURI(0);
    }
}
