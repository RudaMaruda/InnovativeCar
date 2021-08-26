/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class creates telemetries records with specific parameters
**/
@isTest
public class TestTelemetriesFactory {

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method creates a certain number of records with an assigned
     * created date and saves them in the database
     **/
    public static List<Telemetry__c> createTelemetryInsert(Integer numberTelemetries, DateTime CreatedDateTest){
        List<Telemetry__c> telemetryList = new List<Telemetry__c>();
        Datetime dateTest = CreatedDateTest;
        
        for(Integer i = 0; i <  numberTelemetries ; i++) {
            telemetryList.add(New Telemetry__c( Name = 'Test Telemetry' + i));
        }
        
        insert telemetryList;
        
        for (Telemetry__c telemetry : telemetryList){
            Test.setCreatedDate(telemetry.id, dateTest);
        }
        
        return telemetryList;   
    }
}