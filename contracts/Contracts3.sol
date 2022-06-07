//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.5;
import "hardhat/console.sol";

contract Storage {
    address headquarters;

    Ambush public ambush;

    struct Ambush {
        bool alerted;
        uint256 enemies;
        bool armed;
    }
}

contract Sidekick is Storage {
    address behavior;

    constructor(address _headquarters, address _behavior) {
        headquarters = _headquarters;
        behavior = _behavior;
        console.log("constructor msg.sender", msg.sender);
    }

    function alert(uint256 enemies, bool armed) external {
        // TODO: use the behavior's recordAmbush to store the ambush
        console.log("msg.sender alert", msg.sender);
        require(msg.sender == headquarters, "wrong msg.sender");
        //delegate call delegates all the info from whoever called this function to the next duncction
        behavior.delegatecall(
            abi.encodeWithSignature(
                "recordAmbush(uint256,bool)",
                enemies,
                armed
            )
        );
    }
}

contract Behavior is Storage {
    function recordAmbush(uint256 enemies, bool armed) external {
        console.log(msg.sender, "in ambush record");
        // TODO: ensure that only headquarters can send this message, otherwise revert
        require(msg.sender == headquarters, "can only be called by hQ");
        console.log("msg.sender", msg.sender, "headqs", headquarters);
        ambush = Ambush(true, enemies, armed);
    }
}
