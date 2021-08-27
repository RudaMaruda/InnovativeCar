/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class creates car dealership records with specific parameters
**/
@isTest
public class CarsDealershipFactory {

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method creates a certain number of records with an assigned
     * account id
     **/
    public static List<CarsDealership__c> createCarsDealershipInsert(Integer numberCarsDealership, String accountId){
        List<CarsDealership__c> carsDealershipList = new List<CarsDealership__c>();

        for (Integer i = 0; i < numberCarsDealership; i++) {
            CarsDealership__c carsDealership = new CarsDealership__c(Name = 'Test CarsDealership '+ i,
                                                            Cars_Dealership_City__c = 'Test City '+ i,
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = accountId,
                                                            Cars_Dealership_Street__c = 'Test Street '+ i,
                                                            Cars_Dealership_Street_Number__c = (10 + i),
                                                            Dealership_Website__c = 'www.test.com '+ i);
            carsDealershipList.add(carsDealership);
        }

        return carsDealershipList;
    } 

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 27/08/2021
     * @description This method creates one record with an assigned
     * account id
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
