/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class contains business logic for car triggers
**/
public class CarHandler {

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description The method creates a new ReviewCarDeletion object that will keep data about deleted cars
     **/
    public static void carDeletion(List<Car__c> carList) {

        if(carList.isEmpty()) {
            return;
        }
            List<ReviewCarDeletion__c> reviewList = new List<ReviewCarDeletion__c>();
        
            for (Car__c car :carList) {
                String nameReviewCarDeletion = 'Raport ';
                ReviewCarDeletion__c reviewCarDeletion = new ReviewCarDeletion__c( Name = nameReviewCarDeletion + car.Name);
                String prefixForReport = 'Deletion car with name ';
                String textReportDeletion = prefixForReport + car.Name;
                reviewCarDeletion.ReportDeletion__c = textReportDeletion;
                reviewList.add(reviewCarDeletion);
            }
     
            if(reviewList.size() > 0) {
              insert reviewList; 
            }  
    }   
}