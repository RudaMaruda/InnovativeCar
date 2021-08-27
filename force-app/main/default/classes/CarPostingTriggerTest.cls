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
        Account account = AccountFactory.getSimpleAccount();
        insert account;

        CarsDealership__c carsDealership = CarsDealershipFactory.createSimpleCarsDealership(account.Id);
        insert carsDealership;

        Car__c car = CarFactory.createSimpleCar();
        insert car;

        Car_Posting__c carPosting1 = TestCarPostingFactory.createSimpleCarPosting(car.id,carsDealership.id,typePhysical);
        insert carPosting1;
        
        Car_Posting__c carPosting2 = TestCarPostingFactory.createSimpleCarPosting(car.id,carsDealership.id,typePhysical);
        

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
        Account account = AccountFactory.getSimpleAccount();
        insert account;

        CarsDealership__c carsDealership = CarsDealershipFactory.createSimpleCarsDealership(account.Id);
        insert carsDealership;

        Car__c car = CarFactory.createSimpleCar();
        insert car;

        Car_Posting__c carPosting1 = TestCarPostingFactory.createSimpleCarPosting(car.id,carsDealership.id,typeVirtual);
        insert carPosting1;
        
        Car_Posting__c carPosting2 = TestCarPostingFactory.createSimpleCarPosting(car.id,carsDealership.id,typePhysical);

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
        Account account = AccountFactory.getSimpleAccount();
        insert account;
        
        CarsDealership__c carsDealership = CarsDealershipFactory.createSimpleCarsDealership(account.Id);
        carsDealership.Car_Quantity__c = 3;
        insert carsDealership;
        
        Car__c car1 = CarFactory.createSimpleCar();
        car1.Power__c = 200;
        
        Car__c car2 = CarFactory.createSimpleCar();
        
        List<Car__c> carList = new List<Car__c>();
        carList.add(car1);
        carList.add(car2);
        insert carList;
        
        Car_Posting__c carPosting1 = TestCarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,typePhysical);
        Car_Posting__c carPosting2 = TestCarPostingFactory.createSimpleCarPosting(car2.id,carsDealership.id,typeVirtual);
        Car_Posting__c carPosting3 = TestCarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,typeVirtual);
        
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();
        carPostingList.add(carPosting1);
        carPostingList.add(carPosting2);
        carPostingList.add(carPosting3);
        insert carPostingList;
        
        Car_Posting__c carPosting4 = TestCarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,typeVirtual);
        
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
        Account account = AccountFactory.getSimpleAccount();
        insert account;
        
        CarsDealership__c carsDealership = CarsDealershipFactory.createSimpleCarsDealership(account.Id);
        carsDealership.Car_Quantity__c = 4;
        insert carsDealership;
        
        Car__c car1 = CarFactory.createSimpleCar();
        car1.Power__c = 200;
        
        Car__c car2 = CarFactory.createSimpleCar();
        
        List<Car__c> carList = new List<Car__c>();
        carList.add(car1);
        carList.add(car2);
        insert carList;
        
        Car_Posting__c carPosting1 = TestCarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,typePhysical);
        Car_Posting__c carPosting2 = TestCarPostingFactory.createSimpleCarPosting(car2.id,carsDealership.id,typeVirtual);
        Car_Posting__c carPosting3 = TestCarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,typeVirtual);
        
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();
        carPostingList.add(carPosting1);
        carPostingList.add(carPosting2);
        carPostingList.add(carPosting3);
        insert carPostingList;
        
        Car_Posting__c carPosting4 = TestCarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,typeVirtual);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(carPosting4, false);
        Test.stopTest();
        
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add two physical offers for the same car
     * with using factory
     **/
    @isTest
    static void testCarPostingWithLargeAmountsPsyhicalCarPosting(){
        String typePhysical = 'Physical';
        String typeVirtual = 'Virtual';
        Account account = AccountFactory.getSimpleAccount();
        insert account;
              
        Car__c car = CarFactory.createSimpleCar();
        insert car;

        CarsDealership__c carsDealershipFromFactory =
        CarsDealershipFactory.createSimpleCarsDealership(account.id);
        insert carsDealershipFromFactory;

        List<Car_Posting__c> carPostingPhysicalList = 
        TestCarPostingFactory.createCarPosting(120,car.Id,carsDealershipFromFactory.Id,typePhysical);
        List<Car_Posting__c> carPostingVirtualList = 
        TestCarPostingFactory.createCarPosting(20,car.Id,carsDealershipFromFactory.Id,typeVirtual);

        Test.startTest();
        Database.SaveResult[] resultPhysicalList = Database.insert(carPostingPhysicalList, false);
        Database.SaveResult[] resultVirtualLIst = Database.insert(carPostingVirtualList, false);
        Test.stopTest();

        List<Database.SaveResult> resultErrorList = new List<Database.SaveResult>();
        List<Database.SaveResult> resultSuccessList = new List<Database.SaveResult>();
        
        for(Database.SaveResult saveResult : resultPhysicalList){
            if(!saveResult.isSuccess()){
                resultErrorList.add(saveResult);
            }
        }
        for(Database.SaveResult saveResult : resultVirtualLIst){
            if(!saveResult.isSuccess()){
                resultErrorList.add(saveResult);
            }
        }

        for(Database.SaveResult saveResult : resultVirtualLIst){
            if(saveResult.isSuccess()){
                resultSuccessList.add(saveResult);
            }
        }

        System.assert(resultSuccessList.size()>0);
        System.assertEquals(20,resultSuccessList.size());
        System.assert(resultErrorList.size()>0);
        System.assertEquals(119,resultErrorList.size());
    }
}
