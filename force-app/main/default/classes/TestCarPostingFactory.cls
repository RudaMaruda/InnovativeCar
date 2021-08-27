/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class creates car posting records with specific parameters
**/
@isTest
public  class TestCarPostingFactory {
    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method creates a certain number of records with an assigned
     * car dealership id and saves them in the database
     **/
    public static List<Car_Posting__c> createCarPostingPhysical(Integer numberCarPostings,Id idCar,Id idCarsDealership){
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();
        String typeCarPosting = 'Physical';

        for (Integer i = 0; i < numberCarPostings; i++) {
            Car_Posting__c carPosting = new Car_Posting__c(Car__c = idCar, CarsDealership__c = idCarsDealership, Type__c = typeCarPosting);
            carPostingList.add(carPosting);
        }

        if(carPostingList.size()>0) {
            insert carPostingList;  
        }
        
        return carPostingList;
    }

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method creates a certain number of records with an assigned
     * car dealership id and type car posting
     **/
    public static List<Car_Posting__c> createCarPosting(Integer numberCarPostings,Id idCar,Id idCarsDealership, String typeCarPosting){
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();
        
        for (Integer i = 0; i < numberCarPostings; i++) {
            Car_Posting__c carPosting = new Car_Posting__c(Car__c = idCar, CarsDealership__c = idCarsDealership, Type__c = typeCarPosting);
            carPostingList.add(carPosting);
        }
       
        return carPostingList;
    }

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 27/08/2021
     * @description This method creates one record with an assigned
     * car dealership id and type car posting
     **/
    public static Car_Posting__c createSimpleCarPosting(Id idCar,Id idCarsDealership, String typeCarPosting){
        
        Car_Posting__c carPosting = new Car_Posting__c(Car__c = idCar, CarsDealership__c = idCarsDealership, Type__c = typeCarPosting);
        
        return carPosting;
    }
}
