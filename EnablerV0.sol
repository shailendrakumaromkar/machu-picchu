pragma solidity ^0.7.1;
pragma experimental ABIEncoderV2;

contract EnablerV0 {
    
    uint public potAmount;
    
    struct  Member  {
        address memberAddr;
        string name;
        uint memberContribution;
        uint countMemberContribution;
    }
    
    Member _member;
    
    //Get member balance
    mapping (address => uint) public balances;
    
    uint MTBF =48;
    
    //Register a member
    function registerMember(string memory _name) public payable {
        _member.memberAddr = msg.sender;
        _member.name = _name;
        _member.memberContribution +=msg.value;
        _member.countMemberContribution++;
        potAmount+=msg.value;
    }
    
    //Get member details
    function getMemberDetails() public view returns (Member memory) {
     return _member;
    }
    
    //Calculate merit of member based on Avg monthly contribution
    function calcMerit() public view returns (uint) {
        
        uint merit = _member.memberContribution/_member.countMemberContribution;
        return merit;
    }
    
    //Value of % loss will come from Watcher function
    function getGroupLossPercent() public pure returns (uint) {
        //sample lo25Percent value as 25
        return 25;
    }
    
    //Calculate Compensation of partiucualr member & transfer to member account
    function calcCompensation(address _reciever) public {
        
        //Below value will come from Watcher smart contract
        uint lossPercent = getGroupLossPercent();
        uint merit = calcMerit();
        uint compAmount;
        
        compAmount = lossPercent * merit * MTBF/100 ; 
        balances[_reciever] += compAmount;
        potAmount -= compAmount;
   }
}
