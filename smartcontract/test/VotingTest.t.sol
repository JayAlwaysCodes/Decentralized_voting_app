// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Voting.sol";

contract VotingTest is Test {
    Voting voting;
    address owner = address(0x1234);
    address voter1 = address(0x5678);
    address voter2 = address(0x9ABC);

    string[] candidateNames = ["Alice", "Bob"];

    function setUp() public {
        // Setup the test environment
        vm.startPrank(owner);
        voting = new Voting(candidateNames, 10); // 10 minutes duration
        vm.stopPrank();
    }

    function testInitialSetup() public {
        // Check initial setup of candidates and owner
        assertEq(voting.owner(), owner);
        Voting.Candidate[] memory candidates = voting.getAllVotesOfCandidates();
        assertEq(candidates.length, 2);
        assertEq(candidates[0].name, "Alice");
        assertEq(candidates[1].name, "Bob");
    }

    function testAddCandidate() public {
        // Add a new candidate
        vm.startPrank(owner);
        voting.addCandidate("Charlie");
        vm.stopPrank();

        Voting.Candidate[] memory candidates = voting.getAllVotesOfCandidates();
        assertEq(candidates.length, 3);
        assertEq(candidates[2].name, "Charlie");
    }

    function testVote() public {
        // Test voting functionality
        vm.startPrank(voter1);
        voting.vote(0);
        vm.stopPrank();

        Voting.Candidate[] memory candidates = voting.getAllVotesOfCandidates();
        assertEq(candidates[0].voteCount, 1);

        vm.startPrank(voter2);
        voting.vote(1);
        vm.stopPrank();

        candidates = voting.getAllVotesOfCandidates();
        assertEq(candidates[1].voteCount, 1);

        // Test that a voter cannot vote twice
        vm.startPrank(voter1);
        vm.expectRevert("You have already voted.");
        voting.vote(1);
        vm.stopPrank();
    }

    function testVotingStatus() public {
        // Test voting status and remaining time
        assertTrue(voting.getVotingStatus());

        // Simulate time passage
        vm.warp(block.timestamp + 600); // 10 minutes

        assertFalse(voting.getVotingStatus());
        assertEq(voting.getRemainingTime(), 0);
    }
}
