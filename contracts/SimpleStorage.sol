// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SimpleStorage is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
     constructor() ERC721("MyToken", "MTK") {}
    string ipfsHash;
     function set(string memory x) public {
    ipfsHash = x;
  }

  function get() public view returns (string memory) {
    return ipfsHash;
  }

    string baseURL = "https://ipfs.io/ipfs/";


    function safeMint() public  {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
         string memory imageURI = string(abi.encodePacked(baseURL,ipfsHash));
        _setTokenURI(tokenId, imageURI);
    }

    // The following functions are overrides required by Solidity.
    //let con = await SimpleStorage.deployed();

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}