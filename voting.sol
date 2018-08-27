pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;

contract Voting {
    mapping (bytes32 => uint8) private _votesReceived;
    
    string[] public candidateList;
    
    constructor(string[] candidateNames) public {
        candidateList = candidateNames;
    }
    
    function votesReceived(string candidate) view returns(uint8) {
        return _votesReceived[keccak256(candidate)];
    }
    
    function totalVotesFor(string candidate) constant public returns (uint8) {
        require(validCandidate(candidate) == true);
        return _votesReceived[keccak256(candidate)];
    }
    
    function voteForCandidate(string candidate) {
        assert(validCandidate(candidate) == true);
        _votesReceived[keccak256(candidate)] += 1;
    }
    
    function validCandidate(string candidate) constant public returns (bool) {
        for (uint i = 0; i < candidateList.length; i++) {
            if (keccak256(candidateList[i]) == keccak256(candidate)) {
                return true;
            }
        }
        return false;
    }
}