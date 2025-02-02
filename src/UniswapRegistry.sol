// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract UniswapRegistry is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    // dai/weth means dai to weth
    // dai/weth => array[dai, weth]

    mapping(string => address) private uniswapTokenToAddress;

    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address constant WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;

    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
        uniswapTokenToAddress["weth"] = WETH;
        uniswapTokenToAddress["usdc"] = USDC;
        uniswapTokenToAddress["dai"] = DAI;
        uniswapTokenToAddress["wbtc"] = WBTC;
    }

    // ---------- Getter Functions --------------

    function getAddressFromString(
        string memory tokenName
    ) public view returns (address) {
        return uniswapTokenToAddress[tokenName];
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal virtual onlyOwner override {}
}
