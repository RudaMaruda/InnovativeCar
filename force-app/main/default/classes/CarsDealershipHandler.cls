/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class contains business logic for car dealership triggers
**/
public class CarsDealershipHandler {

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method checks that the number of cars for the car dealership has the correct value
     * @Task: Task 4
     * @param carsDealershipList List with new car dealerships 
     **/
    public static void restrictCarQuantity(List<CarsDealership__c> carsDealershipList){
        
        if(carsDealershipList.isEmpty()) {
            System.debug(LoggingLevel.ERROR,Constants.ERROR_ENTRY_PARAMETR_NULL);
            return;
        }

        for (CarsDealership__c carsDealership: carsDealershipList){
        if(carsDealership.Car_Quantity__c <= 0){
            carsDealership.AddError(Constants.ERROR_CAR_DEALERSHIP_CAR_QUANTITY);
        }
        }
    }
    
    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method refers to the asynchronous method when the car dealership changes from open to closed
     * @Task: Task 5
     * @param carsDealershipOldList List with car dealerships before update
     * @param carsDealershipNewList List with car dealerships to be updated
     **/
    public static void closeCarsDealership(List<CarsDealership__c> carsDealershipOldList,List<CarsDealership__c> carsDealershipNewList){
        Map<Id,CarsDealership__c> carsDealershipIdWithStatusOpenMap = new Map<Id,CarsDealership__c>(
            [Select Id, Dealership_Status__c 
            From CarsDealership__c 
            Where Id =: carsDealershipOldList AND
            Dealership_Status__c =: Constants.CAR_DEALERSHIP_STATUS_OPEN]);

        for (CarsDealership__c carsDealership : carsDealershipNewList){
            if(carsDealershipIdWithStatusOpenMap.get(carsDealership.Id).Dealership_Status__c != null &&
            carsDealership.Dealership_Status__c == Constants.CAR_DEALERSHIP_STATUS_CLOSE){
                AsyncCaseRenovation asyncCaseRenovation = new AsyncCaseRenovation(carsDealership.id);
            }
        }
    }
}