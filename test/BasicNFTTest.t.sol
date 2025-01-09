// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicnft;
    address public USER = makeAddr("user");
    string public PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicnft = deployer.run();
    }

    function testNameIsCorrect() public view {
        // assertEq(basicnft.name(), "Dogie");
        string memory expectedName = "Dogie";
        string memory actualName = basicnft.name();
        assert(
            keccak256(abi.encode(expectedName)) ==
                keccak256(abi.encode(actualName)) // We did this because natively these strings are stored in the form of arrays
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicnft.mintNFT(PUG_URI);
        assert(basicnft.balanceOf(USER) == 1);
        assertEq(PUG_URI, basicnft.tokenURI(0));
    }
}
