// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {MVTOKEN} from "src/MVTOKEN.sol";
import {Evaluator} from "src/Evaluator.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // vm.startBroadcast(vm.envUint("anvil"));
        MVTOKEN erc20 = new MVTOKEN();
        vm.stopBroadcast();
    }
}
