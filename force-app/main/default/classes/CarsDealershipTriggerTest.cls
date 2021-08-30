/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class has test methods for the car dealership 
**/
@isTest
public class CarsDealershipTriggerTest {
    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add car quantity below zero
     * @Task: Task 4
     **/
    @isTest
    static void testAddedCarQuantityWithNumberBelowZero(){
        Account account = AccountFactory.getSimpleAccount();
        insert account;
        
        CarsDealership__c carsDealership = CarsDealershipFactory.createSimpleCarsDealership(account.id);
        carsDealership.Car_Quantity__c = -5;
        
        Test.startTest();
        Database.SaveResult result = Database.insert(carsDealership, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals(Constants.ERROR_CAR_DEALERSHIP_CAR_QUANTITY,result.getErrors()[0].getMessage());    
    }
    
    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add car quantity equal to zero
     * @Task: Task 4
     **/
    @isTest
    static void testAddedCarQuantityWithNumberIsZero(){
        Account account = AccountFactory.getSimpleAccount();
        insert account;
        
        CarsDealership__c carsDealership = CarsDealershipFactory.createSimpleCarsDealership(account.id);
        carsDealership.Car_Quantity__c = 0;
        
        Test.startTest();
        Database.SaveResult result = Database.insert(carsDealership, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals(Constants.ERROR_CAR_DEALERSHIP_CAR_QUANTITY,result.getErrors()[0].getMessage());  
    }
}