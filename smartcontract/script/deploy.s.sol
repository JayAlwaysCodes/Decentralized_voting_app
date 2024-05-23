// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/Voting.sol";

contract DeployVoting is Script {
    function run() external {
        string[] memory candidateNames = new string[](2);
        candidateNames[0] = "Alice";
        candidateNames[1] = "Bob";
        uint256 durationInMinutes = 10;

        vm.startBroadcast();
        Voting voting = new Voting(candidateNames, durationInMinutes);
        vm.stopBroadcast();

        console.log("Voting contract deployed at:", address(voting));
    }
}
