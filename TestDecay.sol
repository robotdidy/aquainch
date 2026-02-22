// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestDecay {
    uint216 public storedOffset;
    uint40 public storedTime;

    function getOffset(uint256 decayPeriod) public view returns (uint256) {
        uint256 expiration = storedTime + decayPeriod;
        if (block.timestamp >= expiration) {
            return 0;
        }
        uint256 timeLeft = expiration - block.timestamp;
        return uint256(storedOffset) * timeLeft / decayPeriod;
    }

    function addOffset(uint256 offset, uint256 decayPeriod) public {
        uint256 current = getOffset(decayPeriod);
        uint256 newOffset = current + offset;
        storedOffset = uint216(newOffset);
        storedTime = uint40(block.timestamp);
    }

    function set(uint216 offset, uint40 time) public {
        storedOffset = offset;
        storedTime = time;
    }
}
