pragma solidity >=0.4.22 <0.7.0;
contract ECAS  {
    
      mapping(uint => participation) ER; 
     enum incentive_status{incentivized, not_incentivized}
     

     struct participation{
         string name;
         uint reg;
         address adr;
         string eventname;
         uint rank;
         string incentive_sts;
         ECAS.incentive_status status;
     }
     participation e;

     address owner;
     
      constructor() public {
          owner = msg.sender;
      }
      
      modifier isOwner() {

         require(msg.sender == owner, "Access is not allowed");

         _;

     }

    
     function participant_details(string memory NAME,uint REG_NO,address ADDRESS,string memory EVENT_NAME,uint RANK, string memory _incentive_sts)public isOwner {
        
         e.name = NAME;
         e.reg = REG_NO;
         e.adr=ADDRESS;
         e.eventname=EVENT_NAME;
         e.rank=RANK;
         e.incentive_sts = _incentive_sts;
         e.status=incentive_status.not_incentivized;
         
        ER[REG_NO] = e;
        
         }

  
          
         function fetch_details(uint REG_NO) public view returns (string memory NAME,string memory EVENT_NAME , uint RANK ,string memory _incentive_sts)
         {
             
            participation memory e = ER[REG_NO];
     
            return (e.name,e.eventname,e.rank, e.incentive_sts);
    

         }
    function INCENTIVE_BY_REG(uint REG_NO ) public payable{
            participation memory e=  ER[REG_NO];
            e.adr;
            
             require(e.status == incentive_status.not_incentivized,"Already incentivized");
             (bool sent, bytes memory data) = e.adr.call.value(msg.value)("");
             require (sent,"Failed to incentivize");
             e.status =incentive_status.incentivized;
            
           
    
            }

             
   
        
          
     
          
         
          
          
}