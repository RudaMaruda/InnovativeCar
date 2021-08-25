@isTest
public class BatchTelemetriesDeletionTest {
    @isTest static void testBatchWhenInsertOldTelemetries () {
        
        
        Datetime dayBeforeYesterday = Datetime.now().addDays(-2);
        List<Telemetry__c> lst_telemetries = TestTelemetriesFactory.createTelemetryInsert(100,dayBeforeYesterday);
        
        System.debug('List with telemetries, size before deleted old records: '+lst_telemetries.size());
        
        Test.startTest();
        ID BatchProcessdId = Database.executeBatch(new OldTelemetriesDeletion());
        Test.stopTest();
        
        
        Integer expectedNumOfTelemetry = [SELECT COUNT() FROM Telemetry__c];
        System.assertEquals(0, expectedNumOfTelemetry);   
    }
    
    @isTest static void testBatchWhenInsertNewTelemetries () {
        
        
        Datetime today = Datetime.now();
        List<Telemetry__c> lst_telemetries = TestTelemetriesFactory.createTelemetryInsert(100,today);
        
        System.debug(lst_telemetries.size());
        
        Test.startTest();
        ID BatchProcessdId = Database.executeBatch(new OldTelemetriesDeletion());
        Test.stopTest();
        
        
        Integer expectedNumOfTelemetry = [SELECT COUNT() FROM Telemetry__c];
        System.assertEquals(100, expectedNumOfTelemetry);   
    }
    
    @isTest static void testBatchWhenInsertNewAndOldTelemetries () {
        
        
        Datetime today = Datetime.now();
        Datetime dayBeforeYesterday = Datetime.now().addDays(-2);
        
        List<Telemetry__c> lst_telemetriesNew = TestTelemetriesFactory.createTelemetryInsert(70,today);
        List<Telemetry__c> lst_telemetriesOld = TestTelemetriesFactory.createTelemetryInsert(20,dayBeforeYesterday);
        
        List<Telemetry__c> lst_telemetriesAll = [SELECT id FROM Telemetry__c];
        
        System.debug('Old and new telemetries list size: '+lst_telemetriesAll.size());
        
        Test.startTest();
        ID BatchProcessdId = Database.executeBatch(new OldTelemetriesDeletion());
        Test.stopTest();
        
        
        Integer expectedNumOfTelemetry = [SELECT COUNT() FROM Telemetry__c];
        System.assertEquals(70, expectedNumOfTelemetry);   
    }
    
    
    
}