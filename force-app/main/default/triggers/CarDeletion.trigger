trigger CarDeletion on Car__c (before delete) {
     
    
    
    List<Car__c> deletedCars = new List<Car__c>();
    
    for (Car__c c :Trigger.old){
        deletedCars.add(c);
        System.debug('Car with brand'+c.Brand__c + ' was deleted. Dont forget to check if the disposal was succesfull');
    }
 
   //insert deletedCars;
    System.debug(deletedCars.size());
   

}