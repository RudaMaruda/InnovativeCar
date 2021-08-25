@isTest
public class TestTelemetriesFactory {
    
    public static List<Telemetry__c> createTelemetryInsert(Integer numTelemetries, DateTime CreatedDateTest){
        
        List<Telemetry__c> lst_telemetries = new List<Telemetry__c>();
        
        Datetime dateTest = CreatedDateTest;
        
        for(Integer i = 0; i <  numTelemetries ; i++) {
            lst_telemetries.add(New Telemetry__c( Name = 'Test Telemetry' + i));
        }
        
       insert lst_telemetries;
        
        for (Telemetry__c telem : lst_telemetries){
            
            Test.setCreatedDate(telem.id, dateTest);
        }
        
        return lst_telemetries;
        
    }

}