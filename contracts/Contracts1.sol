//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.5;

contract Sidekick {
    function sendAlert(address hero) external {
        (bool success, ) = hero.call(abi.encodeWithSignature("alert()"));
        //chhange abi content to alert above
        require(success);
    }
}

contract Hero {
    bool public alerted;

    function alert() external {
        alerted = true;
    }
}
