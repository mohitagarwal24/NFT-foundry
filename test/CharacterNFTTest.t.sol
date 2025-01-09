// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployCharacterNFT} from "../script/DeployCharacterNFT.s.sol";
import {CharacterNFT} from "../src/CharacterNFT.sol";

contract CharacterNFTTest is Test {
    DeployCharacterNFT public deployer;
    CharacterNFT public characterNft;
    address public USER = makeAddr("user");

    function setUp() public {
        deployer = new DeployCharacterNFT();
        characterNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Character";
        string memory actualName = characterNft.name();
        assert(
            keccak256(abi.encode(expectedName)) ==
                keccak256(abi.encode(actualName)) // We did this because natively these strings are stored in the form of arrays
        );
    }

    function testCanMintAndHaveABalance() public {
        string memory uri = characterNft.getTokenUriByName("Doraemon");
        vm.prank(USER);
        characterNft.MintNft("Doraemon");
        assert(characterNft.balanceOf(USER) == 1);
        assertEq(uri, characterNft.tokenURI(0));
    }

}
