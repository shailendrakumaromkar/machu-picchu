pragma solidity ^0.7.1;
pragma experimental ABIEncoderV2;

contract EnablerV1 {
    
    uint public potAmount;
    address owner;
    
    //Defining Member struct
    struct  Member  {
        address memberAddr;
        string name;
        uint memberContribution;
        uint onboardingDate;
    }
    
    //Creating Struct object
    Member _member;
    
    //Get member balance
    mapping (address => uint) public balances;
    
    //Considering MTBF of the community as 48 months = 4 years
    uint MTBF = 48;
    
    //Initialising Owner
    constructor () {
        owner = msg.sender;
    }
    
    // Only Enabler modifier
     modifier onlyEnabler {
        require (msg.sender == owner);
        _;
    }
    
    //Defining an event post Compensation amount Transfer
    event CompensationTransfer (address member, uint amount);
    
    
    //Register a member
    function registerMember(string memory _name) public payable {
        _member.memberAddr = msg.sender;
        _member.name = _name;
        _member.memberContribution +=msg.value;
        /*this is hardcoded value only to test Merit in Enabler smart contract
        below line will be uncommented in Final
        _member.onboardingDate = block.timestamp; */
        _member.onboardingDate = 1498867200;
        potAmount+=msg.value;
    }
    
    //Get member details
    function getMemberDetails() public view returns (Member memory) {
     return _member;
    }
    
    //Calculate merit of member based on Avg monthly contribution
    function calcMerit() public onlyEnabler view  returns (uint) {
     
        uint totalMonth = (block.timestamp - _member.onboardingDate)/60/60/24/30;
        uint merit = _member.memberContribution/totalMonth;
        
        return merit;
    }
    
    //Value of % loss will come from Watcher smart contract
    function getGroupLossPercent() public pure returns (uint) {
        //sample lo25Percent value as 25
        return 25;
    }
    
    //Calculate Compensation of partiucualr member & transfer to member account
    function calcCompensation(address _receiver) public onlyEnabler {
        
        //Below value will come from Watcher smart contract
        uint lossPercent = getGroupLossPercent();
        uint merit = calcMerit();
        uint compAmount;
        
        compAmount = lossPercent * merit * MTBF/100 ; 
        balances[_receiver] += compAmount;
        
        require (potAmount >= compAmount);
        
        potAmount -= compAmount;
        
        emit CompensationTransfer(_receiver,compAmount);
   }
}
