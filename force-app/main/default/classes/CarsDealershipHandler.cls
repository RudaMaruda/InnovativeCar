/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class contains business logic for car dealership triggers
**/
public class CarsDealershipHandler {

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method checks that the number of cars for the car dealership has the correct value
     **/
    public static void restrictCarQuantity(List<CarsDealership__c> carsDealershipList){
        
        if(carsDealershipList.isEmpty()) {
            return;
        }

        for (CarsDealership__c carsDealership: carsDealershipList){
        if(carsDealership.Car_Quantity__c <= 0){
            String errorMessage = 'Car Quantity must be above 0!';
            carsDealership.AddError(errorMessage);
        }
        }
    }
    
    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method refers to the asynchronous method when the car dealership changes from open to closed
     **/
    public static void closeCarsDealership(List<CarsDealership__c> carsDealershipOldList,List<CarsDealership__c> carsDealershipNewList){
        String carDealershipStatusOpen = 'Open';
        String carDealershipStatusClose = 'Close';

        for (CarsDealership__c carsDealershipOld : carsDealershipOldList){
            if(carsDealershipOld.Dealership_Status__c == carDealershipStatusOpen){
                 
                for (CarsDealership__c carsDealershipNew : carsDealershipNewList){
                    if(carsDealershipNew.Dealership_Status__c == carDealershipStatusClose && carsDealershipNew.id == carsDealershipOld.id ){
                        AsyncCaseRenovation asyncCaseRenovation = new AsyncCaseRenovation(carsDealershipNew.id);
                        Id jobID = System.enqueueJob(asyncCaseRenovation);   
                    }
                }
            }
        }
    }
}