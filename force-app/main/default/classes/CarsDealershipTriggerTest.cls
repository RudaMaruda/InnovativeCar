/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class has test methods for the car dealership 
**/
@isTest
public class CarsDealershipTriggerTest {
    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add car quantity below zero
     **/
    @isTest
    static void testAddedCarQuantityWithNumberBelowZero(){
        Account account = new Account (Name = 'Test Account');
        insert account;
        
        CarsDealership__c carsDealership = new CarsDealership__c(Name = 'Test CarsDealership',
                                                            Cars_Dealership_City__c = 'Test City',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = account.Id,
                                                            Cars_Dealership_Street__c = 'Test Street',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com',
                                                            Car_Quantity__c = -5);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(carsDealership, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        String errorMessage = 'Car Quantity must be above 0!';
        System.assertEquals(errorMessage,result.getErrors()[0].getMessage());    
    }
    
    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add car quantity equal to zero
     **/
    @isTest
    static void testAddedCarQuantityWithNumberIsZero(){
        Account account = new Account (Name = 'Test Account');
        insert account;
        
        CarsDealership__c carsDealership = new CarsDealership__c(Name = 'Test CarsDealership',
                                                            Cars_Dealership_City__c = 'Test City',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = account.Id,
                                                            Cars_Dealership_Street__c = 'Test Street',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com',
                                                            Car_Quantity__c = 0);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(carsDealership, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        String errorMessage = 'Car Quantity must be above 0!';
        System.assertEquals(errorMessage,result.getErrors()[0].getMessage());  
    }
}