/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class creates car dealership records with specific parameters
**/
@isTest
public class CarsDealershipFactory {

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method creates a certain number of records with an assigned
     * account id
     * @Task: Task 4
     * @param numberCarsDealership The number of car dealership that will be generated 
     * @param accountId The id of the account that the car dealership will apply to
     * @return List<CarsDealership__c> List with car dealerships 
     **/
    public static List<CarsDealership__c> createCarsDealershipInsert(Integer numberCarsDealership, String accountId){
        List<CarsDealership__c> carsDealershipList = new List<CarsDealership__c>();

        for (Integer i = 0; i < numberCarsDealership; i++) {

            CarsDealership__c carsDealership = CarsDealershipFactory.createSimpleCarsDealership(accountId);
            carsDealership.Name = carsDealership.Name + i;
            carsDealership.Cars_Dealership_City__c = carsDealership.Cars_Dealership_City__c + i;
            carsDealership.Cars_Dealership_Street__c = carsDealership.Cars_Dealership_Street__c + i;
            carsDealership.Cars_Dealership_Street_Number__c = carsDealership.Cars_Dealership_Street_Number__c + i;

            carsDealershipList.add(carsDealership);
        }

        return carsDealershipList;
    } 

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 27/08/2021
     * @description This method creates one record with an assigned
     * account id
     * @Task: Task 4
     * @param accountId The id of the account that the car dealership will apply to
     * @return CarsDealership__c One car dealership 
     **/
    public static CarsDealership__c createSimpleCarsDealership(String accountId){
        
        CarsDealership__c carsDealership = new CarsDealership__c(Name = 'Test CarsDealership ',
                                                            Cars_Dealership_City__c = 'Test City ',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = accountId,
                                                            Cars_Dealership_Street__c = 'Test Street ',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com ');
            
        return carsDealership;
    }
}
