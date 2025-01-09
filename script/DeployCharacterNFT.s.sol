// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {CharacterNFT} from "../src/CharacterNFT.sol";

contract DeployCharacterNFT is Script {
    function run() external returns (CharacterNFT) {
        vm.startBroadcast();
        CharacterNFT characterNft = new CharacterNFT();
        vm.stopBroadcast();
        return characterNft;
    }
}
