// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import ""

contract Voting{

    struct Voter {
        string name;
        string votedCandidate;
    }

    struct Candidate {
        string id;
        string name;
        string pictureLink;
        uint voteCount; 
    }

    mapping(string=>bool)  voted;
    mapping(string=>uint) indexes;

    Candidate[] public candidates;
    Voter[] public voters;

    modifier restricted(){
        require(msg.sender == manager);
        _;
    }

    function InitVoting(address creator,string electionName,string electionDescription,uint electionStartdate, uint electionEnddate) public{
        manager = creator;
        nameOfElection = electionName;
        description = electionDescription;
        startdate = electionStartdate;
        enddate = electionEnddate;
        electionState = 1;
    }

    function addCandidate( string id, string name, string pictureLink, ) public restricted{
        require(now < startdate );
         Candidate memory  newCandidate = Candidate({
            id:id,
            name:name,
            pictureLink:pictureLink,
            voteCount:0
        });

        indexes[id] = candidates.length;
        candidates.push(newCandidate);
    }

    function vote(string candidateId,string name,string phoneNumber) public {
        require( (now > startdate ) && (now < enddate) );
        require(!voted[phoneNumber]);
        uint index = indexes[candidateId];
        Candidate storage candidate = candidates[index];
        candidate.voteCount++;
        Voter memory  newVoter = Voter({
            name:name,
            votedCandidate:candidateId
        });
        voters.push(newVoter);
        voted[phoneNumber] = true;
        totalVoteCount++;
    }

    function hasVoted(string identifier) public view returns (bool){
        bool userHashasVoted = voted[identifier];
        return userHashasVoted;
    }
    // function to get voters length
    function getVotersLength() public view returns (uint){
        return voters.length;
    }
    // function to get all the stats of an election
    function getStats() public view returns(uint,uint,string,int,string){
        uint localNumCandidate = candidates.length;
        if(localNumCandidate>0){
            uint leadingCandidate = 0;
            for (uint i = 1;i<candidates.length;i++){
                if(candidates[i].voteCount>candidates[leadingCandidate].voteCount){
                    leadingCandidate = i;
                }
            }

            int localLeadingCandidateVote = candidates[leadingCandidate].voteCount;
            string storage localLeadingCandidateName = candidates[leadingCandidate].name;
            string storage localLeadingCandidatePicture = candidates[leadingCandidate].pictureLink;

            return (localNumCandidate,totalVoteCount,localLeadingCandidateName,localLeadingCandidateVote,localLeadingCandidatePicture);
        }
        else{
            return (0,0,"",0,"");
        }
    }
}