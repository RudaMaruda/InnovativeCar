@isTest
public class TestCarPostingNew1 {
    
    @isTest static void TestCarPostingWithFewPsyhicalOffer(){
        
        Account acct = new Account (Name = 'Test Account');
        
        insert acct;
        
        CarsDealership__c carDealer1 = new CarsDealership__c(Name = 'Test CarsDealership',
                                                            Cars_Dealership_City__c = 'Test City',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = acct.Id,
                                                            Cars_Dealership_Street__c = 'Test Street',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com');
        insert carDealer1;
        
        Car__c car1 = new Car__c(Name = 'Test Car1',
                               VIN__c = '6774656TTR',
                                Brand__c = 'Brand1',
                                Model__c = 'Model1',
                                Condition__c = 'Saled',
                                Price__c = 40000,
                                Equipment__c = 'Test equipment',
                                Power__c = 150,
                                Capacity__c = 500,
                                Combustion__c = 10,
                                Car_Type_Available__c = 'sports car');
        
        insert car1;
        
         Car__c car2 = new Car__c(Name = 'Test Car2',
                               VIN__c = '6774656TT2R',
                                Brand__c = 'Brand2',
                                Model__c = 'Model2',
                                Condition__c = 'Saled',
                                Price__c = 44000,
                                Equipment__c = 'Test equipment2',
                                Power__c = 154,
                                Capacity__c = 505,
                                Combustion__c = 11,
                                Car_Type_Available__c = 'sports car');
        
        insert car2;
        
        Car_Posting__c carPost1 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Physical');
        insert carPost1;
        
        Car_Posting__c carPost2 = new Car_Posting__c(Car__c = car2.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Physical');
        
       
      
        
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(carPost2, false);
        
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        
         System.assertEquals('Only one phyical offer could exist!',
                             result.getErrors()[0].getMessage());
    }
    
    @isTest static void TestCarPostingWithOnePsyhicalOffer(){
        
        Account acct = new Account (Name = 'Test Account');
        
        insert acct;
        
        CarsDealership__c carDealer1 = new CarsDealership__c(Name = 'Test CarsDealership',
                                                            Cars_Dealership_City__c = 'Test City',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = acct.Id,
                                                            Cars_Dealership_Street__c = 'Test Street',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com');
        insert carDealer1;
        
        Car__c car1 = new Car__c(Name = 'Test Car1',
                               VIN__c = '6774656TTR',
                                Brand__c = 'Brand1',
                                Model__c = 'Model1',
                                Condition__c = 'Saled',
                                Price__c = 40000,
                                Equipment__c = 'Test equipment',
                                Power__c = 150,
                                Capacity__c = 500,
                                Combustion__c = 10,
                                Car_Type_Available__c = 'sports car');
        
        insert car1;
        
         Car__c car2 = new Car__c(Name = 'Test Car2',
                               VIN__c = '6774656TT2R',
                                Brand__c = 'Brand2',
                                Model__c = 'Model2',
                                Condition__c = 'Saled',
                                Price__c = 44000,
                                Equipment__c = 'Test equipment2',
                                Power__c = 154,
                                Capacity__c = 505,
                                Combustion__c = 11,
                                Car_Type_Available__c = 'sports car');
        
        insert car2;
        
        Car_Posting__c carPost1 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Physical');
        insert carPost1;
        
        Car_Posting__c carPost2 = new Car_Posting__c(Car__c = car2.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Virtual');
        
       
      
        
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(carPost2, false);
        
        Test.stopTest();
        
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
       
    }

}