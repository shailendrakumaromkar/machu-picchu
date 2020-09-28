# machu-picchu
machu-picchu

UI/UX : Draft version, may be modified based on group review feedback/comments 

![Compensation_UI](https://user-images.githubusercontent.com/19868756/94401553-682ea700-0188-11eb-8d7e-f6075c391d0d.png)




Compensation is one of the last module in whole Machu-Picchu project


Compensation is the Heading of the page
Top right you can see the Enabler address 

Under Compensation, It has 2 tabs – Member & Watcher
Enabler can click on either of this 2 tabs

When Enabler clicks on Member tab, it will see sub-tabs - Transfer to Member & Tx Details

Under Transfer to Member
If Enabler selects Transfer to Member, then here Transfer to Member can be initiated by entering below field value
Member Address
Compensation Amount : TBD for calculation
Merit : TBD for calculation
Total : It should be calculated automatically by adding Compensation Amount + Merit
Submit : Once above values are entered, user will click on Submit to initiate Transfer to member address, internally it will call smart contract function transferAmountToMember(address payable _recieverMember, uint _amount) public payable


Tx Details explorer: It will have call method to fetch all the details
When user clicks on this tab, it will list down all the Transaction done to a member
Member Address & Compensation amount



When Enabler clicks on Watcher tab, it will see sub-tabs - Refund to Watcher & Refund Details explorer

Under Refund to Watcher
If Enabler selects Refund to Watcher, then here Refund to Watcher can be initiated by entering below field value
Watcher Address
Reputation: TBD for calculation
Result : TBD for calculation
Total : It should be calculated automatically by adding Result + Reputation
Submit : Once above values are entered, user will click on Submit to initiate Refund to Watcher address, internally it will call smart contract function refundWatcher(address payable _watcherAddress, uint _result) public


Refund Details explorer: It will have call method to fetch all the details
When user clicks on this tab, it will list down all the Refund done to a Watcher
Watcher Address & Refund amount

##Tech Stack

Frontend :  HTML + CSS, Javascript
Middleware : web3.js
Backend : Solidity
Blockchain network– Ganache, Metamask
Framework – truffle



