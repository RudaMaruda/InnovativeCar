trigger CarToWarehouse1 on CarsDealership__c (after update) {
    
    List<Id> listId = new List<Id>();
    for (CarsDealership__c c : Trigger.old){
        listId.add(c.Account__c);
    }
    
    
    List<CarsDealership__c> warehouseForCarDealership = [SELECT Id FROM CarsDealership__c 
                                                         WHERE 
                                                         Warehouse_status__c = true 
                                                         And Account__c IN :listId]; 
    
    
    List<CarsDealership__c> carFromCloseDealership = 
        [SELECT Id,Dealership_Status__c,(select id from Car_Postings__r) FROM CarsDealership__c 
         where Dealership_Status__c = 'Close' and Id IN :Trigger.old]; 
    
    
    if(carFromCloseDealership.size() >0){
        List<Car_Posting__c> listCarPost = carFromCloseDealership.get(0).Car_Postings__r;
        
        system.debug('From trigger CarToWarehouse1,Car posting list with car to move to warehouse '+ listCarPost);
        system.debug('Warehouse contains: '+warehouseForCarDealership);
        
        system.debug('Id car dealership which is warehouse: '+ warehouseForCarDealership.get(0).id);
        system.debug('Car posting in warehouse: '+warehouseForCarDealership.get(0).Car_postings__r);  
        
        String idWarehouse = warehouseForCarDealership.get(0).id;
        
        
        List<Car_Posting__c> carPostInWarehouse = new List <Car_Posting__c>();
        
        // car dealership <- car posting -> car
        
        List<Id> listIdCP = new List<Id>();
        for (Car_Posting__c cp : listCarPost){
            listIdCP.add(cp.Car__c);
        }
        
       
        List<Car__c> carList = [SELECT Id FROM Car__c WHERE ID IN :listIdCP];
        
        
        for (Car__c c : carList){
            system.debug('Next car: '+ c);
            
            carPostInWarehouse.add(new Car_Posting__c(Car__c = c.id,CarsDealership__c = idWarehouse));
           
        }
        
        insert carPostInWarehouse;
       
    }
    
}