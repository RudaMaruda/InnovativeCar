/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class creates car posting records with specific parameters
**/
@isTest
public  class CarPostingFactory {
    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method creates a certain number of records with an assigned
     * car dealership id, type specified as 'physical' and saves them in the database
     * @Task: Task 4
     * @param numberCarPostings The number of car posting that will be generated 
     * @param idCar The id of the car that the car posting will apply to
     * @param idCarsDealership The id of the car dealership that the car posting will apply to
     * @return List<Car_Posting__c> List with physical car postings
     **/
    public static List<Car_Posting__c> createCarPostingPhysical(Integer numberCarPostings,Id idCar,Id idCarsDealership){
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();

        for (Integer i = 0; i < numberCarPostings; i++) {
            Car_Posting__c carPosting = new Car_Posting__c(Car__c = idCar, CarsDealership__c = idCarsDealership, Type__c = Constants.CAR_POSTING_TYPE_PHYSICAL);
            carPostingList.add(carPosting);
        }

        if(carPostingList.size()>0) {
            insert carPostingList;  
        }
        
        return carPostingList;
    }

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method creates a certain number of records with an assigned
     * car dealership id and type car posting
     * @Task: Task 4
     * @param numberCarPostings The number of car posting that will be generated 
     * @param idCar The id of the car that the car posting will apply to
     * @param idCarsDealership The id of the car dealership that the car posting will apply to
     * @param typeCarPosting The type of the car posting
     * @return List<Car_Posting__c> List with car postings with specified parameters
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
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 27/08/2021
     * @description This method creates one record with an assigned
     * car dealership id and type car posting
     * @Task: Task 4
     * @param idCar The id of the car that the car posting will apply to
     * @param idCarsDealership The id of the car dealership that the car posting will apply to
     * @param typeCarPosting The type of the car posting
     * @return Car_Posting__c One car posting with specified parameters
     **/
    public static Car_Posting__c createSimpleCarPosting(Id idCar,Id idCarsDealership, String typeCarPosting){
        
        Car_Posting__c carPosting = new Car_Posting__c(Car__c = idCar, CarsDealership__c = idCarsDealership, Type__c = typeCarPosting);
        
        return carPosting;
    }
}
