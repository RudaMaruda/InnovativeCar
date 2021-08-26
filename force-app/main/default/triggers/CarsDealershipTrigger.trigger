/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This trigger applies to tasks performed for car dealership
**/
trigger CarsDealershipTrigger on CarsDealership__c (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            CarsDealershipHandler.restrictCarQuantity(trigger.new);
        }

        if(Trigger.isUpdate){
            CarsDealershipHandler.closeCarsDealership(trigger.old, trigger.new);
        } 
    }
}