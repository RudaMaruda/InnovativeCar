public class CarsDealershipHandler {

    
    public static void restrictCarQuantity(List<CarsDealership__c> carsDealership){
        
         for (CarsDealership__c c: carsDealership){
        if(c.Car_Quantity__c <= 0){
            c.AddError('Car Quantity must be above 0!');
        }
    }
    }
    
    public static void closeCarsDealership(List<CarsDealership__c> carsDealershipOld,List<CarsDealership__c> carsDealershipNew){
        
        List<CarsDealership__c> carsDealershipWithOldStatusOpen = [Select id, Dealership_Status__c from CarsDealership__c where Dealership_Status__c='Open' AND id =: carsDealershipOld];
        
        List<Id> idCarD = new List<Id>();
        for (CarsDealership__c c : carsDealershipWithOldStatusOpen){
            idCarD.add(c.id);
        }
        
       // List<CarsDealership__c> carsDealershipWithNewStatusClose = [Select id, Dealership_Status__c from CarsDealership__c where ]
        
        for(CarsDealership__c cNew: carsDealershipNew){
            //if(cNew.Dealership_Status__c == 'Close' && cNew.id =: idCarD){
                
               // Case newCase = new Case(Name)
                
                
           // }
        }
    }
}