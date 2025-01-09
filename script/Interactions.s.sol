// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {CharacterNFT} from "../src/CharacterNFT.sol";

contract MintBasicNft is Script {
    string public PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNFTonContract(mostRecentlyDeployed);
    }

    function mintNFTonContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNFT(contractAddress).mintNFT(PUG_URI);
    }
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNFT",
            block.chainid
        );
        mintNFTonContract(mostRecentlyDeployed);
    }

    function mintNFTonContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNFT(contractAddress).MintNft();
    }
}

contract FlipMoodNft is Script{
    uint256 private s_tokenId;
    constructor(uint256 tokenId) {
        s_tokenId=tokenId;
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNFT",
            block.chainid
        );
        flipNftonContract(mostRecentlyDeployed);
    }

    function flipNftonContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNFT(contractAddress).flipMood(s_tokenId);
    }
}

// by deafult mints doraemon 
contract MintCharacterNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "CharacterNFT",
            block.chainid
        );
        mintNFTonContract(mostRecentlyDeployed);
    }

    function mintNFTonContract(address contractAddress) public {
        vm.startBroadcast();
        CharacterNFT(contractAddress).MintNft("Doraemon");
    }
} 


