/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class contains business logic for carPosting triggers
**/
public class CarPostingHandler {

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description The method checks whether the added car offer already exists
     **/
    public static void addCarPostingPhysical(List<Car_Posting__c> carPostingList){
        
        if(carPostingList.isEmpty()) {
            return;
        }

        String typePhysical = 'Physical';
        List<Car_Posting__c> carPostingPhysicalList = [Select Id,Car__c, Type__c from Car_Posting__c where Type__c =: typePhysical];
        List<id> idList = new List<Id>();
        
        for (Car_Posting__c carPosting : carPostingPhysicalList) {
            idList.add(carPosting.Car__c);
        }
        
        for (Car_Posting__c carPosting : carPostingList) {
            Id carId = carPosting.Car__c;
            if(idList.contains(carId) && carPosting.Type__c == typePhysical) {
                String errorMessage = 'Only one physical offer could exist for this car!';
                carPosting.addError(errorMessage);
            }
        } 
    }
    
    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description The method checks whether the number of added offers for the car dealership does not exceed
     * the allowable amount specified by the dealership
     **/
    public static void addCarPostingLimit(List<Car_Posting__c> carPostingList){

        if(carPostingList.isEmpty()) {
            return;
        }

        List<Id> idCarDealershipList = new List<Id>();

        for(Car_Posting__c carPosting : carPostingList){
            idCarDealershipList.add(carPosting.CarsDealership__c);
        }

        Map<Id,CarsDealership__c> carsDealershipIdWithCarQuantityMap = new Map<Id,CarsDealership__c>(
            [Select Id, Car_Quantity__c from CarsDealership__c where Id =: idCarDealershipList]);
        Map<Id,CarsDealership__c> carsDealershipIdWithCarPostingMap = new Map<Id,CarsDealership__c>(
            [Select Id,(Select Id from Car_Postings__r) from CarsDealership__c where Id =: idCarDealershipList]);

            for (Car_Posting__c carPosting : carPostingList) {
                Id carsDealershipId = carPosting.CarsDealership__c;

                if(carsDealershipIdWithCarQuantityMap.get(carsDealershipId).Car_Quantity__c != null &&
                carsDealershipIdWithCarPostingMap.get(carsDealershipId).Car_Postings__r.size()>0){
                    Decimal carQuantity = carsDealershipIdWithCarQuantityMap.get(carsDealershipId).Car_Quantity__c;
                    Decimal carPostingCount = carsDealershipIdWithCarPostingMap.get(carsDealershipId).Car_Postings__r.size();
                    if(carQuantity<(carPostingCount + 1)) {
                        String errorMessage = 'Available only car quantity: ';
                        carPosting.AddError(errorMessage + carQuantity);
                    }
                }           
            }  
    }
    
    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description The method sends an email to the sales director when there are new offers in the car dealership
     **/
    public static void sendEmailSalesDirector(List<Car_Posting__c> carPostingList){
        
        if(carPostingList.isEmpty()) {
            return;
        }
        
        String nameRole = 'Director, Direct Sales';
        UserRole userRole = [SELECT Id FROM UserRole WHERE Name =: nameRole LIMIT 1];
        User userDirector = [SELECT Id, Name, UserRoleId, email FROM User where UserRoleId =:userRole.id LIMIT 1];
        String emailUserDirector = userDirector.email;
        String subject = 'Information about new car postings';
        String body = '';
        
        for(Car_Posting__c carPosting : carPostingList){ 
            String carPostingInfo = ' New carPosting with name was added: ';
            body = body + carPostingInfo + carPosting.Name;
        }
        
        SendEmailFutureClass.sendEmailToSalesDirector(emailUserDirector,subject,body);
    }  
}