pragma solidity ^0.8.0;

contract GamifiedVoting {
    struct Voter {
        uint256 votingPower;
        uint256 votesCast;
    }
    
    mapping(address => Voter) public voters;
    mapping(bytes32 => uint256) public proposals;
    
    function engage() public {
        voters[msg.sender].votingPower += 1;
    }
    
    function vote(bytes32 proposal) public {
        require(voters[msg.sender].votingPower > 0, "No voting power");
        
        uint256 power = voters[msg.sender].votingPower;
        proposals[proposal] += power;
        voters[msg.sender].votesCast += power;
        voters[msg.sender].votingPower = 1; // Reset to base level after voting
    }
    
    function getProposalVotes(bytes32 proposal) public view returns (uint256) {
        return proposals[proposal];
    }
    
    function getVoterData(address voter) public view returns (uint256, uint256) {
        return (voters[voter].votingPower, voters[voter].votesCast);
    }
}
