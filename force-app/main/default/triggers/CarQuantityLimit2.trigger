trigger CarQuantityLimit2 on Car_Posting__c (before insert) {
    
    
    List<Id> listId = new List<Id>();
    for (Car_Posting__c c : Trigger.new){
        listId.add(c.CarsDealership__c);
    }
    
    List<CarsDealership__c> carsdealer = [SELECT Id,Car_Quantity__c FROM CarsDealership__c WHERE 
                                                id IN :listId];
    
       List<Car_Posting__c> carPostListExist = [SELECT Id,Name FROM Car_Posting__c 
                                                WHERE 
                                                CarsDealership__c IN :listId];
    
    Decimal carQuant = carsdealer.get(0).Car_Quantity__c;
    
    for (Car_Posting__c c : Trigger.new){
       
        if ((carPostListExist.size()+1) > carQuant){
            c.AddError('Available only '+carQuant+' car posting!');
        }
    }
    
}