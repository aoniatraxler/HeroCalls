//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.5;

contract Sidekick {
    function sendAlert(
        address hero,
        uint256 enemies,
        bool armed
    ) external {
        //alert the hero!
        (bool success, ) = hero.call(
            abi.encodeWithSignature("alert(uint256,bool)", enemies, armed)
        );
        require(success, "Not successfully called");
    }
}

contract Hero {
    Ambush public ambush;

    struct Ambush {
        bool alerted;
        uint256 enemies;
        bool armed;
    }

    function alert(uint256 enemies, bool armed) external {
        ambush = Ambush(true, enemies, armed);
    }
}
