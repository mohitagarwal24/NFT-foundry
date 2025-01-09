// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract CharacterNFT is ERC721 {
    error CharacterNFT__CanChangeCharacterByOwner();
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;
    mapping(string => string) private s_tokenUris;
    uint256 private constant MAX_SUPPLY = 3000;

    constructor() ERC721("Character", "CH") {
        s_tokenCounter = 0;
        s_tokenUris[
            "Doraemon"
        ] = "ipfs://bafkreidqknq7bkdy3m44lnb25fabol2htyudyfdllsu2lw3rc2lfti2hey";
        s_tokenUris[
            "Nobita"
        ] = "ipfs://bafkreiacsq3d57nvk3ufnyps4tcgrqzvnlzrwofzosvnd3cwy7hrjrshzi";
        s_tokenUris[
            "Shizuka"
        ] = "ipfs://bafkreihisvxvh3rbmlytowcp4zn2rtyoqe6bbfoa5ppr3rlihqqoitou2a";
        s_tokenUris[
            "Gian"
        ] = "ipfs://bafkreib457ok4juyko2fzcfr2qoooz3m3j56sagvy6btfkk2phurwsn3p4";
        s_tokenUris[
            "Suneo"
        ] = "ipfs://bafkreibkd4f7kn43bf4fl6anegifafbnz57nh6nepuaxisjwny3kzctqle";
    }

    function MintNft(string memory charName) public {
        require(s_tokenCounter<MAX_SUPPLY, "Max Supply Reached");
        s_tokenIdToUri[s_tokenCounter] = s_tokenUris[charName];
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function ChangeCharacter(uint256 tokenId, string memory charName) public {
        if (!_isAuthorized(ownerOf(tokenId), msg.sender, tokenId)) {
            revert CharacterNFT__CanChangeCharacterByOwner();
        }
        s_tokenIdToUri[tokenId] = getTokenUriByName(charName);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }

    function getTokenUriByName(
        string memory charName
    ) public view returns (string memory) {
        return s_tokenUris[charName];
    }
}
