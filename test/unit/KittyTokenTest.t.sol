// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployKittyToken} from "../../script/DeployKittyToken.s.sol";
import {KittyToken} from "../../src/KittyToken.sol";

contract KittyTokenTest is Test {
    KittyToken kittyToken;
    address kitty = makeAddr("kitty");
    address doggie = makeAddr("doggie");
    uint256 START_BALANCE = 10 ether;
    uint256 initAllowance = 1 ether;

    uint256 HIGH_BALANCE = 1000 ether;
    uint256 initSupply;

    function setUp() external {
        DeployKittyToken deployKittyToken = new DeployKittyToken();
        (kittyToken, initSupply) = deployKittyToken.run();

        vm.deal(kitty, START_BALANCE);
        vm.deal(doggie, START_BALANCE);

        vm.prank(msg.sender);
        kittyToken.transfer(kitty, START_BALANCE);  // 10 Kitty Tokens
    }

    function test_ConstructorSetsUpStuffCorrectly() public {
        assertEq(kittyToken.totalSupply(), initSupply);
        assertEq(kittyToken.name(), "Kitty");
        assertEq(kittyToken.symbol(), "PAW");
    }

    function test_KittyBalance() public {
        assertEq(kittyToken.balanceOf(kitty), START_BALANCE);
    }

    function test_Allowance_Reverts_If_FromHasNotGiveEnoughTokenSpendingPermission() public {
        vm.prank(kitty);
        kittyToken.approve(doggie, initAllowance);

        vm.expectRevert("ERC20: insufficient allowance");
        vm.prank(doggie);
        kittyToken.transferFrom(kitty, doggie, initAllowance + 1);
    }

    function test_Allowance() public {
        vm.prank(kitty);
        kittyToken.approve(doggie, initAllowance);

        vm.prank(doggie);
        kittyToken.transferFrom(kitty, doggie, initAllowance);

        assertEq(kittyToken.balanceOf(kitty), START_BALANCE - initAllowance);
        assertEq(kittyToken.balanceOf(doggie), initAllowance);
    }

    function test_Transfer_Reverts_SenderHasNotEnoughBalance() public {
        vm.prank(kitty);

        vm.expectRevert("ERC20: transfer amount exceeds balance");
        kittyToken.transfer(doggie, START_BALANCE + 1);
    }

    function test_TransferFrom_Reverts_If_FromHasNotEnoughToken() public {
        // Approval is given to spend 20 Kitty Tokens, but the owner has not enough token, then it should revert

        vm.prank(kitty);
        kittyToken.approve(doggie, HIGH_BALANCE);

        vm.prank(doggie);
        vm.expectRevert("ERC20: transfer amount exceeds balance");
        kittyToken.transferFrom(kitty, doggie, HIGH_BALANCE);
    }
}