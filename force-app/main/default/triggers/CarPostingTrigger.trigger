/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This trigger applies to tasks performed for car posting
**/
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
            CarPostingHandler.sendEmailSalesDirector(Trigger.New);
        }
    } 
}