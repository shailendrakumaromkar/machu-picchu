pragma solidity ^0.7.1;

contract Compensation {
    
    //Total pot contributon, let's say 100 ETH
    uint public pot=100;
    
    //Sample merit stored
    uint merit = 10;
    
    //sample Watcher data
    address watcherAddress;
    uint watcherStake = 20;
    
    address enablerAddress;
    
    
    struct Member {
        uint memberId;
        string village;
        uint lat;
        uint lng;
        uint balance;
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
    
    
    mapping (address => uint) public memberBalances;
    

    event TransferToMember (address member, uint Amount);
    event RefundWatcher (address Watcher, uint Amount);
    
    
     // function computeCompensation() public return (uint) {
        
        
    //     return
        
    // }
    
    
    function transferAmountToMember(address payable _recieverMember, uint _amount) public payable {
        
        uint _finalAmount = _amount + merit;
        pot -=_amount;
       _recieverMember.transfer(_finalAmount);
        
        
        emit TransferToMember(_recieverMember, _amount);
        
    }
    
    
      function refundWatcher(address payable _watcherAddress, uint _result) public {
        
      
        
        if (_result < 10) {
            _watcherAddress.transfer(watcherStake - watcherStake *1/100);
            
        } else if (_result>90) {
            _watcherAddress.transfer(watcherStake + watcherStake * 9/100);
        } 
       
        emit RefundWatcher (_watcherAddress, watcherStake);
        
      }
        

    
    
    //  function getBalance(address _recieverMember) public view returns (uint) {
        
    //     return memberBalances[_recieverMember];
    // }
    

   
    }
    
