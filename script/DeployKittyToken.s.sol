// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {KittyToken} from "../src/KittyToken.sol";

contract DeployKittyToken is Script {
    uint256 initSupply = 100 ether;

    function run() external returns (KittyToken, uint256) {

        vm.startBroadcast();

        KittyToken kittyToken = new KittyToken(initSupply);

        vm.stopBroadcast();

        return (kittyToken, initSupply);
    }
}