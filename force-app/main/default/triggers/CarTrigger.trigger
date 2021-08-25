trigger CarTrigger on Car__c (before delete) {
    
    
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            CarHandler.carDeletion(Trigger.old);
        }
    }
    
    
}