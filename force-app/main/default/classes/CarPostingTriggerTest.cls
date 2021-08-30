/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class has test methods for the car posting triggers
**/
@isTest
public class CarPostingTriggerTest {

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add two physical offers for the same car
     * @Task: Task 4
     **/
    @isTest
    static void testCarPostingWithFewPsyhicalOfferForOneCar(){
        Account account = AccountFactory.getSimpleAccount();
        insert account;

        CarsDealership__c carsDealership = CarsDealershipFactory.createSimpleCarsDealership(account.Id);
        insert carsDealership;

        Car__c car = CarFactory.createSimpleCar();
        insert car;

        Car_Posting__c carPosting1 = CarPostingFactory.createSimpleCarPosting(car.id,carsDealership.id,Constants.CAR_POSTING_TYPE_PHYSICAL);
        insert carPosting1;
        
        Car_Posting__c carPosting2 = CarPostingFactory.createSimpleCarPosting(car.id,carsDealership.id,Constants.CAR_POSTING_TYPE_PHYSICAL);
        

        Test.startTest();
        Database.SaveResult result = Database.insert(carPosting2, false);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add a physical and virtual offer for the same car
     * @Task: Task 4
     **/
    @isTest
    static void testCarPostingWithAddOnePsyhicalOfferForOneCar(){
        Account account = AccountFactory.getSimpleAccount();
        insert account;

        CarsDealership__c carsDealership = CarsDealershipFactory.createSimpleCarsDealership(account.Id);
        insert carsDealership;

        Car__c car = CarFactory.createSimpleCar();
        insert car;

        Car_Posting__c carPosting1 = CarPostingFactory.createSimpleCarPosting(car.id,carsDealership.id,Constants.CAR_POSTING_TYPE_VIRTUAL);
        insert carPosting1;
        
        Car_Posting__c carPosting2 = CarPostingFactory.createSimpleCarPosting(car.id,carsDealership.id,Constants.CAR_POSTING_TYPE_PHYSICAL);

        Test.startTest();
        Database.SaveResult result = Database.insert(carPosting2, false);
        Test.stopTest();

        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add the number of offers above the limit for the car dealership
     * @Task: Task 4
     **/
    @isTest
    static void TestCarQuantityLimitCarPostingWithOveralQuantity(){ 
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
        
        Car_Posting__c carPosting1 = CarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,Constants.CAR_POSTING_TYPE_PHYSICAL);
        Car_Posting__c carPosting2 = CarPostingFactory.createSimpleCarPosting(car2.id,carsDealership.id,Constants.CAR_POSTING_TYPE_VIRTUAL);
        Car_Posting__c carPosting3 = CarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,Constants.CAR_POSTING_TYPE_VIRTUAL);
        
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();
        carPostingList.add(carPosting1);
        carPostingList.add(carPosting2);
        carPostingList.add(carPosting3);
        insert carPostingList;
        
        Car_Posting__c carPosting4 = CarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,Constants.CAR_POSTING_TYPE_VIRTUAL);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(carPosting4, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals(Constants.ERROR_AVAILABLE_CAR_QUANTITY + carsDealership.Car_Quantity__c,result.getErrors()[0].getMessage());    
    }

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add the number of offers below the limit for the car dealership
     * @Task: Task 4
     **/
    @isTest
    static void TestCarQuantityLimitCarPostingWithCorrectQuantity(){
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
        
        Car_Posting__c carPosting1 = CarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,Constants.CAR_POSTING_TYPE_PHYSICAL);
        Car_Posting__c carPosting2 = CarPostingFactory.createSimpleCarPosting(car2.id,carsDealership.id,Constants.CAR_POSTING_TYPE_VIRTUAL);
        Car_Posting__c carPosting3 = CarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,Constants.CAR_POSTING_TYPE_VIRTUAL);
        
        List<Car_Posting__c> carPostingList = new List<Car_Posting__c>();
        carPostingList.add(carPosting1);
        carPostingList.add(carPosting2);
        carPostingList.add(carPosting3);
        insert carPostingList;
        
        Car_Posting__c carPosting4 = CarPostingFactory.createSimpleCarPosting(car1.id,carsDealership.id,Constants.CAR_POSTING_TYPE_VIRTUAL);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(carPosting4, false);
        Test.stopTest();
        
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if it is possible to add large physical offers and large virtual offers for the same car
     * @Task: Task 4
     **/
    @isTest
    static void testCarPostingWithLargeAmountsPsyhicalCarPosting(){
        Account account = AccountFactory.getSimpleAccount();
        insert account;
              
        Car__c car = CarFactory.createSimpleCar();
        insert car;

        CarsDealership__c carsDealershipFromFactory =
        CarsDealershipFactory.createSimpleCarsDealership(account.id);
        insert carsDealershipFromFactory;

        List<Car_Posting__c> carPostingPhysicalList = 
        CarPostingFactory.createCarPosting(120,car.Id,carsDealershipFromFactory.Id,Constants.CAR_POSTING_TYPE_PHYSICAL);
        List<Car_Posting__c> carPostingVirtualList = 
        CarPostingFactory.createCarPosting(20,car.Id,carsDealershipFromFactory.Id,Constants.CAR_POSTING_TYPE_VIRTUAL);

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
