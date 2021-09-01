/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class contains business logic for carPosting triggers
**/
public class CarPostingHandler {

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description The method checks whether the added car offer already exists
     * @Task: Task 4
     * @param carPostingList List with car postings 
     **/
    public static void addCarPostingPhysical(List<Car_Posting__c> carPostingList){
        
        if(carPostingList.isEmpty()) {
            System.debug(LoggingLevel.ERROR,Constants.ERROR_ENTRY_PARAMETR_NULL);
            return;
        }

        List<Car_Posting__c> carPostingPhysicalList = [Select Id,Car__c, Type__c 
                                                      From Car_Posting__c
                                                      Where Type__c =: Constants.CAR_POSTING_TYPE_PHYSICAL];
        List<id> idList = new List<Id>();

        List<Car_Posting__c> carPostingPhysicalListNew = new List<Car_Posting__c>();
        
        for (Car_Posting__c carPosting : carPostingPhysicalList) {
            idList.add(carPosting.Car__c);
        }
        
        for (Car_Posting__c carPosting : carPostingList) {
            Id carId = carPosting.Car__c;
            if(idList.contains(carId) && carPosting.Type__c == Constants.CAR_POSTING_TYPE_PHYSICAL) {
                carPosting.addError(Constants.ERROR_EXIST_PHYSICAL_OFFER);
            }
            if(carPosting.Type__c == Constants.CAR_POSTING_TYPE_PHYSICAL && carPostingPhysicalListNew.contains(carPosting)){
                carPosting.addError(Constants.ERROR_EXIST_PHYSICAL_OFFER);
            }

            if(carPosting.Type__c == Constants.CAR_POSTING_TYPE_PHYSICAL){
                carPostingPhysicalListNew.add(carPosting);
            }
        } 
    }
    
    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description The method checks whether the number of added offers for the car dealership does not exceed
     * the allowable amount specified by the dealership
     * @Task: Task 4
     * @param carPostingList List with car postings
     **/
    public static void addCarPostingLimit(List<Car_Posting__c> carPostingList){

        if(carPostingList.isEmpty()) {
            System.debug(LoggingLevel.ERROR,Constants.ERROR_ENTRY_PARAMETR_NULL);
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
                        carPosting.AddError(Constants.ERROR_AVAILABLE_CAR_QUANTITY + carQuantity);
                    }
                }           
            }  
    }
    
    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description The method sends an email to the sales director when there are new offers in the car dealership
     * @Task: Task 5
     * @param carPostingList List with car postings
     **/
    public static void sendEmailSalesDirector(List<Car_Posting__c> carPostingList){
        
        if(carPostingList.isEmpty()) {
            System.debug(LoggingLevel.ERROR,Constants.ERROR_ENTRY_PARAMETR_NULL);
            return;
        }
        
        List<UserRole> userRoleList = [SELECT Id FROM UserRole WHERE Name =: Constants.ROLE_NAME];
        UserRole userRole = userRoleList.get(0);
        User userDirector = [SELECT Id, Name, UserRoleId, email FROM User where UserRoleId =:userRole.id LIMIT 1];
        String emailUserDirector = userDirector.email;
        String body = '';
        
        for(Car_Posting__c carPosting : carPostingList){ 
            body = body + Constants.INFO_CAR_POSTING_EMAIL + carPosting.Name;
        }
        
        SendEmailFutureClass.sendEmailToSalesDirector(emailUserDirector,Constants.SUBJECT_CAR_POSTING_EMAIL,body);
    }  
}