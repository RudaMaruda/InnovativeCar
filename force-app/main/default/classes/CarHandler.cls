/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class contains business logic for car triggers
**/
public class CarHandler {

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description The method creates a new ReviewCarDeletion object that will keep data about deleted cars
     * @Task: Task 4
     * @param carList List with cars that will be removed  
     **/
    public static void carDeletion(List<Car__c> carList) {

        if(carList.isEmpty()) {
            System.debug(LoggingLevel.ERROR,Constants.ERROR_ENTRY_PARAMETR_NULL);
            return;
        }
            List<ReviewCarDeletion__c> reviewList = new List<ReviewCarDeletion__c>();
            List<Id> carIdList = new List<Id>();
        
            for (Car__c car :carList) {
                ReviewCarDeletion__c reviewCarDeletion = new ReviewCarDeletion__c( Name = Constants.REVIEW_NAME + car.Name);
                String textReportDeletion = Constants.REVIEW_PREFIX + car.Name;
                reviewCarDeletion.ReportDeletion__c = textReportDeletion;
                reviewList.add(reviewCarDeletion);
                carIdList.add(car.id);
            }
            
            /**
            * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
            * @date 27/08/2021 Added telemetry list which should be deleted with deleted cars
            * @description 
            **/
            List<Telemetry__c> telemetriesToDeleteList = 
                [Select id,Name,Car__c from Telemetry__c where Car__c =: carIdList];

            if(telemetriesToDeleteList.size() > 0) {
                delete telemetriesToDeleteList;
              }
     
            if(reviewList.size() > 0) {
              insert reviewList; 
            }  
    }   
}