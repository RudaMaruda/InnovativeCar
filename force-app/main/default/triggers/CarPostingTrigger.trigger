trigger CarPostingTrigger on Car_Posting__c (before insert,after insert, before update) {
    
    if(Trigger.isBefore){
        
        if(Trigger.isInsert){
            
            CarPostingHandler.addCarPostingPhysical(Trigger.New);
            
                       
            CarPostingHandler.addCarPostingLimit(Trigger.New); 
        }
        
        if(Trigger.isUpdate){
            CarPostingHandler.addCarPostingPhysical(Trigger.New);
          
        }
        
        
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            CarPostingHandler.sendEmailSalesDir(Trigger.New);
        }
    }
    
}