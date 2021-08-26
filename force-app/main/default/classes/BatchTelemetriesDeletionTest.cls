/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class has test methods for the batch class
**/
@isTest
public class BatchTelemetriesDeletionTest {

     /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if telemetry data older than 2 days will be deleted
     **/
    @isTest
    static void testBatchWhenInsertOldTelemetries () {
        Datetime dayBeforeYesterday = Datetime.now().addDays(-2);
        List<Telemetry__c> telemetryList = TestTelemetriesFactory.createTelemetryInsert(100,dayBeforeYesterday);
                     
        Test.startTest();
        ID BatchProcessdId = Database.executeBatch(new OldTelemetriesDeletion());
        Test.stopTest();
                
        Integer expectedNumberOfTelemetry = [SELECT COUNT() FROM Telemetry__c];
        System.assertEquals(0, expectedNumberOfTelemetry);   
    }
    
     /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if telemetry data created today will be deleted
     **/
    @isTest
    static void testBatchWhenInsertNewTelemetries () {
        Datetime today = Datetime.now();
        List<Telemetry__c> telemetryList = TestTelemetriesFactory.createTelemetryInsert(100,today);
        
        Test.startTest();
        ID BatchProcessdId = Database.executeBatch(new OldTelemetriesDeletion());
        Test.stopTest();
        
        Integer expectedNumberOfTelemetry = [SELECT COUNT() FROM Telemetry__c];
        System.assertEquals(100, expectedNumberOfTelemetry);   
    }
    
    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks if telemetry data created today and 2 days ago will be deleted
     **/
    @isTest
    static void testBatchWhenInsertNewAndOldTelemetries () {
        Datetime today = Datetime.now();
        Datetime dayBeforeYesterday = Datetime.now().addDays(-2);
        
        List<Telemetry__c> telemetryListTodayCreated = TestTelemetriesFactory.createTelemetryInsert(70,today);
        List<Telemetry__c> telemetryLIstOldCreated = TestTelemetriesFactory.createTelemetryInsert(20,dayBeforeYesterday);  
                   
        Test.startTest();
        ID BatchProcessdId = Database.executeBatch(new OldTelemetriesDeletion());
        Test.stopTest();
                
        Integer expectedNumberOfTelemetry = [SELECT COUNT() FROM Telemetry__c];
        System.assertEquals(70, expectedNumberOfTelemetry);   
    } 
}