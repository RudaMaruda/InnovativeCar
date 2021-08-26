/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This trigger applies to tasks performed for car
**/
trigger CarTrigger on Car__c (before delete) {
 if(Trigger.isBefore){
     if(Trigger.isDelete){
         CarHandler.carDeletion(Trigger.old);
     }
 }  
}