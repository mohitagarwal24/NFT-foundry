// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    MoodNFT private moodNft;
    function run() external returns (MoodNFT){
        // in order to read svg file we have already set up access in toml file and we are ready to use cheat code
        string memory sadSVG = vm.readFile("./img/sad.svg");
        string memory happySVG = vm.readFile("./img/happy.svg");
        vm.startBroadcast();
        moodNft = new MoodNFT(svgToImageUri(happySVG), svgToImageUri(sadSVG));
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageUri(string memory svg) public pure returns (string memory){
        string memory baseUri = "data:image/svg+xml;base64,";
        string memory svgbase64encode = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseUri, svgbase64encode));
    }
}
