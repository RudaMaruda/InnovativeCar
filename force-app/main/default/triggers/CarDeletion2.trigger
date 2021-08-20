trigger CarDeletion2 on Car_Posting__c (before delete) {

   
    
    List<Id> listId = new List<Id>();
    for (Car_Posting__c c : Trigger.old){
        listId.add(c.CarsDealership__c);
    }
    //List<Report_De__c> reportList = new List <Report_De__c>();
    List<Report_De__c> reportList = [SELECT Id FROM Report_De__c 
                                                WHERE 
                                                CarsDealershipR__c IN :listId];
    
        
    List<Car_Posting__c> carPostListExist = [SELECT Id,Name FROM Car_Posting__c 
                                                WHERE 
                                                CarsDealership__c IN :listId];
    
    system.debug(carPostListExist);
    
    for (Car_Posting__c c : Trigger.old){
        
reportList.add(new Report_De__c(Description_Repo__c = 'Deleted carPosting with id: '+ c.Id ));       
    
    }
    
    if(reportList.size()>0){
        insert reportList;
    }
    
    
    List<CarsDealership__c> carsdealer = [SELECT Id,(select id from Report_Deletions__r) FROM CarsDealership__c WHERE 
                                                id IN :listId];
    
    
}