pragma solidity ^0.7.1;

contract Compensation {
    
    //Total pot contributon, let's say 100 ETH
    uint public pot=1000;

    
    //sample Watcher data
    address watcherAddress;
    uint public watcherStake = 20;
    uint public merit;
    uint public lossAmount;
    uint public memberBalance = 250;
    uint memberCounter = 10;
    uint public finalAmount;     
    address enablerAddress;
   
    //Referred from contributon smart contract, will be removed during Integration
    struct Member {
        uint memberId;
        string village;
        uint lat;
        uint lng;
        uint balance;
        uint counter;
      }

    mapping (address => Member) public members;
    
    //initialise enabler
    constructor()  {
        enablerAddress = msg.sender;
    }
    
    // Setting only enabler can call function of the smart contract
    modifier onlyEnabler{
        enablerAddress == msg.sender;
        _;
    }
    
    //Referred from contributon smart contract, will be removed during Integration
    mapping (address => uint) public memberBalances;
    
    //Defining event for Transferring Compensation amount
    event TransferToMember (address member, uint Amount);
    
     //Defining event for Refunding Reputation amount
    event RefundWatcher (address Watcher, uint Amount);
    
    //Sample merit stored
    uint samplemerit = 10;
    
    /*
    1. Only Enabler can call this function
    2. Transferring Compensation amount to member
    3. Emiting event with Transfer details
    */
    
    //Currently there's no way to store how many time a member has contributed, so how do we calculate merit ?
    //Even if store merit value, how to use while doing compensation ?
    //In contributon contract, there should be variable counterContribution which get incremented each time member contributes
    //So now we have 2 var Member.balance & counterContribution to calculate merit
    
    //counter variable should be added in Contribution function to keep track on number of Contribution ?
    //Understanding is watcher function will return 2 outputs value (Memeber#Id & %Loss for that particular memeber), 
    //who will calculate %loss, who will combine all memeber data across memeber, refer xls ?
    //who will do the the weighted avg %loss assessment ? Watcher or Enabler as an Insurer they only do the fund transfer ?
    //how to do  weighted avg %loss assessment as in data model we are not storing any info related to this i.e. how much is %loss he assessed for each member ?
    // so how to get the % loss value
    
    
    //counter variable in Contribution function
    //Percentage of damage as assessed by the whole community - this will be calculated in Watcher or Enabler module & how
    //Is merit formula correct
    //Is compensation formula correct
    //How to calculate reputation or for MVP shall we refund complete stake then later addon all validat
    function transferAmountToMember(address payable _recieverMember, uint _percentLoss) public payable {
        lossAmount = _percentLoss *pot/100;
        
        // merit = members[_recieverMember].balance/members[_recieverMember].counter;
        
        merit = memberBalance/memberCounter;
        
        finalAmount = lossAmount + merit;
        
        pot -=finalAmount;
       
        memberBalance =memberBalance + finalAmount;
       
       //_recieverMember.transfer(finalAmount);
        msg.sender.transfer(finalAmount);
        
        //emit TransferToMember(_recieverMember, _finalAmount);
        
    }
    
    //How to calculate the Watcher reputation or for MVP can we transfer only the staked 
    //amount by comparing there individual assessment with group assessment?
    // we need to store watcher assessment as well as this will be used while comparing, computing refund reputation
      function refundWatcher(address payable _watcherAddress, uint _watcherStake) public {
         _watcherAddress.call{ value: _watcherStake };
       
        emit RefundWatcher (_watcherAddress, watcherStake);
        
      }
   
    }
    
