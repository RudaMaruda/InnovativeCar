@isTest
public class TestCarQuantityLimit2 {
    
    @isTest static void TestCarQuantityLimitCarPostingWithOveralQuantity(){
        
        Account acct = new Account (Name = 'Test Account');
        
        insert acct;
        
        CarsDealership__c carDealer1 = new CarsDealership__c(Name = 'Test CarsDealership',
                                                            Cars_Dealership_City__c = 'Test City',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = acct.Id,
                                                            Cars_Dealership_Street__c = 'Test Street',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com',
                                                            Car_Quantity__c = 3);
        
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
        
        List<Car__c> carList = new List<Car__c>();
        carList.add(car1);
        carList.add(car2);
        
        insert carList;
        
        Car_Posting__c carPost1 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Physical');
        
        Car_Posting__c carPost2 = new Car_Posting__c(Car__c = car2.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Virtual');
        Car_Posting__c carPost3 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Virtual');
        
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();
        carPostingList.add(carPost1);
        carPostingList.add(carPost2);
        carPostingList.add(carPost3);
        
        insert carPostingList;
        
        Car_Posting__c carPost4 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Virtual');
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(carPost4, false);
        
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        
         System.assertEquals('Available only '+carDealer1.Car_Quantity__c+' car posting!',result.getErrors()[0].getMessage());
        
        
    }
    
    @isTest static void TestCarQuantityLimitCarPostingWithCorrectQuantity(){
        
        Account acct = new Account (Name = 'Test Account');
        
        insert acct;
        
        CarsDealership__c carDealer1 = new CarsDealership__c(Name = 'Test CarsDealership',
                                                            Cars_Dealership_City__c = 'Test City',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = acct.Id,
                                                            Cars_Dealership_Street__c = 'Test Street',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com',
                                                            Car_Quantity__c = 4);
        
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
        
        List<Car__c> carList = new List<Car__c>();
        carList.add(car1);
        carList.add(car2);
        
        insert carList;
        
        Car_Posting__c carPost1 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Physical');
        
        Car_Posting__c carPost2 = new Car_Posting__c(Car__c = car2.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Virtual');
        Car_Posting__c carPost3 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Virtual');
        
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();
        carPostingList.add(carPost1);
        carPostingList.add(carPost2);
        carPostingList.add(carPost3);
        
        insert carPostingList;
        
        Car_Posting__c carPost4 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carDealer1.id,
                                                    Type__c = 'Virtual');
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(carPost4, false);
        
        Test.stopTest();
        
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
              
        
    }

}