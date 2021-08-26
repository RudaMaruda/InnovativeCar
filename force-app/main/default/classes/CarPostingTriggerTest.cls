/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class has test methods for the car posting triggers
**/
@isTest
public class CarPostingTriggerTest {

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add two physical offers for the same car
     **/
    @isTest
    static void testCarPostingWithFewPsyhicalOfferForOneCar(){
        String typePhysical = 'Physical';
        String typeVirtual = 'Virtual';
        Account account = new Account (Name = 'Test Account');
        insert account;

        // Previously I try use TestCarPostingFactory and CarsDealershipFactory
        // but I received fail msg about number id provided in methods

        CarsDealership__c carsDealership = new CarsDealership__c(Name = 'Test CarsDealership',
        Cars_Dealership_City__c = 'Test City',
        Car_Type__c = 'passenger car',
        Account__c = account.Id,
        Cars_Dealership_Street__c = 'Test Street',
        Cars_Dealership_Street_Number__c = 10,
        Dealership_Website__c = 'www.test.com');

        insert carsDealership;

        Car__c car = new Car__c(Name = 'Test Car1',
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
        
        insert car;

        Car_Posting__c carPosting1 = new Car_Posting__c(Car__c = car.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typePhysical);
        insert carPosting1;
        
        Car_Posting__c carPosting2 = new Car_Posting__c(Car__c = car.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typePhysical);

        Test.startTest();
        Database.SaveResult result = Database.insert(carPosting2, false);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add a physical and virtual offer for the same car
     **/
    @isTest
    static void testCarPostingWithAddOnePsyhicalOfferForOneCar(){
        String typePhysical = 'Physical';
        String typeVirtual = 'Virtual';
        Account account = new Account (Name = 'Test Account');  
        insert account;

        CarsDealership__c carsDealership = new CarsDealership__c(Name = 'Test CarsDealership',
        Cars_Dealership_City__c = 'Test City',
        Car_Type__c = 'passenger car',
        Account__c = account.Id,
        Cars_Dealership_Street__c = 'Test Street',
        Cars_Dealership_Street_Number__c = 10,
        Dealership_Website__c = 'www.test.com');

        insert carsDealership;

        Car__c car = new Car__c(Name = 'Test Car1',
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
        
        insert car;

        Car_Posting__c carPosting1 = new Car_Posting__c(Car__c = car.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typeVirtual);
        insert carPosting1;
        
        Car_Posting__c carPosting2 = new Car_Posting__c(Car__c = car.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typePhysical);

        Test.startTest();
        Database.SaveResult result = Database.insert(carPosting2, false);
        Test.stopTest();

        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add the number of offers above the limit for the car dealership
     **/
    @isTest
    static void TestCarQuantityLimitCarPostingWithOveralQuantity(){ 
        String typePhysical = 'Physical';
        String typeVirtual = 'Virtual';
        Account account = new Account (Name = 'Test Account');
        insert account;
        
        CarsDealership__c carsDealership = new CarsDealership__c(Name = 'Test CarsDealership',
                                                            Cars_Dealership_City__c = 'Test City',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = account.Id,
                                                            Cars_Dealership_Street__c = 'Test Street',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com',
                                                            Car_Quantity__c = 3);
        
        insert carsDealership;
        
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
        
        Car_Posting__c carPosting1 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typePhysical);
        
        Car_Posting__c carPosting2 = new Car_Posting__c(Car__c = car2.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typeVirtual);
        Car_Posting__c carPosting3 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typeVirtual);
        
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();
        carPostingList.add(carPosting1);
        carPostingList.add(carPosting2);
        carPostingList.add(carPosting3);
        
        insert carPostingList;
        
        Car_Posting__c carPosting4 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typeVirtual);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(carPosting4, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        String errorMessage = 'Available only car quantity: ';
        System.assertEquals(errorMessage + carsDealership.Car_Quantity__c,result.getErrors()[0].getMessage());    
    }

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add the number of offers below the limit for the car dealership
     **/
    @isTest
    static void TestCarQuantityLimitCarPostingWithCorrectQuantity(){
        String typePhysical = 'Physical';
        String typeVirtual = 'Virtual';
        Account account = new Account (Name = 'Test Account');
        insert account;
        
        CarsDealership__c carsDealership = new CarsDealership__c(Name = 'Test CarsDealership',
                                                            Cars_Dealership_City__c = 'Test City',
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = account.Id,
                                                            Cars_Dealership_Street__c = 'Test Street',
                                                            Cars_Dealership_Street_Number__c = 10,
                                                            Dealership_Website__c = 'www.test.com',
                                                            Car_Quantity__c = 4);
        
        insert carsDealership;
        
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
        
        Car_Posting__c carPosting1 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typePhysical);
        
        Car_Posting__c carPosting2 = new Car_Posting__c(Car__c = car2.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typeVirtual);
        Car_Posting__c carPosting3 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typeVirtual);
        
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();
        carPostingList.add(carPosting1);
        carPostingList.add(carPosting2);
        carPostingList.add(carPosting3);
        
        insert carPostingList;
        
        Car_Posting__c carPosting4 = new Car_Posting__c(Car__c = car1.id,
                                                    CarsDealership__c = carsDealership.id,
                                                    Type__c = typeVirtual);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(carPosting4, false);
        Test.stopTest();
        
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }
}
