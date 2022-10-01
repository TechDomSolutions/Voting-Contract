// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract VotingFactory {

    struct PollSummary{
        address location;
        string description;
        uint startDate;
        uint endDate;
    } 

    address[] public deployedPolls;
    PollSummary[] public pollSummaries;

    function createPoll(string description,uint startdate, uint enddate) pubblic{
        address newPoll = new Poll(msg.sender,name,description,startdate,enddate);
        Summary memory newSummary = Summary({
            location:newElection,
            description:description,
            startdate:startdate,
            enddate:enddate
        }); 

        pollSummaries.push(newSummary);
        deployedPolls.push(newPoll);
    }
}