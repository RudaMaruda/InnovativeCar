trigger CarsDealershipTrigger on CarsDealership__c (before insert, before update) {
    
    if(Trigger.isBefore){
        
        if(Trigger.isInsert){
  
            CarsDealershipHandler.restrictCarQuantity(trigger.new);
        }
        
        
    }
    
   

}