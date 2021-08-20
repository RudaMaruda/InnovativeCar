@isTest
public class TestRestrictCarQuantity {
    @isTest static void TestAddedCarQuantityWithNumberBelowZero(){

        // Michal please check tests
        
        Account acct = new Account (Name = 'Test Account');
        
        insert acct;
        
        CarsDealership__c carDealer1 = new CarsDealership__c(Name = 'Test CarsDealership',
                                                            Cars_Dealership_City__c = 'Test City',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = acct.Id,
                                                            Cars_Dealership_Street__c = 'Test Street',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com',
                                                            Car_Quantity__c = -5);
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(carDealer1, false);
        
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        
         System.assertEquals('Car Quantity must be above 0!',
                             result.getErrors()[0].getMessage());
        
    }
    
    @isTest static void TestAddedCarQuantityWithNumberIsZero(){
        
        Account acct = new Account (Name = 'Test Account');
        
        insert acct;
        
        CarsDealership__c carDealer1 = new CarsDealership__c(Name = 'Test CarsDealership',
                                                            Cars_Dealership_City__c = 'Test City',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = acct.Id,
                                                            Cars_Dealership_Street__c = 'Test Street',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com',
                                                            Car_Quantity__c = 0);
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(carDealer1, false);
        
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        
         System.assertEquals('Car Quantity must be above 0!',
                             result.getErrors()[0].getMessage());
        
    }

}