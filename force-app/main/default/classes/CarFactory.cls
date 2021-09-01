/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class creates car records with specific parameters
**/
@isTest
public class CarFactory {
    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method creates a certain number of car records and
     * saves them in the database
     * @Task: Task 4
     * @param numberCars The number of cars that will be generated 
     * @return List<Car__c> List with cars with the specified parameters
     **/
    public static List<Car__c> createCarInsert(Integer numberCars){
        List<Car__c> carList = new List<Car__c>();

        for (Integer i = 0; i < numberCars; i++) {
            Car__c car = CarFactory.createSimpleCar();
            car.Name = car.Name + i;
            car.VIN__c = car.VIN__c + i;
            car.Brand__c = car.Brand__c + i;
            car.Model__c = car.Model__c + i;
            carList.add(car);
        }
        if(carList.size()>0){
            insert carList;
        }

        return carList;
    }

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 27/08/2021
     * @description This method creates one car record
     * @Task: Task 4 
     * @return Car__c One car with the specified parameters
     **/
    public static Car__c createSimpleCar(){
        
    Car__c car = new Car__c(Name = 'Test Car ',
                               VIN__c = '6774656TTR',
                                Brand__c = 'Brand',
                                Model__c = 'Model',
                                Condition__c = 'Saled',
                                Price__c = 40000,
                                Equipment__c = 'Test equipment',
                                Power__c = 150,
                                Capacity__c = 500,
                                Combustion__c = 10,
                                Car_Type_Available__c = 'sports car');

        return car;
    }
}
