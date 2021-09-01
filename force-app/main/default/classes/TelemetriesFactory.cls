/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class creates telemetries records with specific parameters
**/
@isTest
public class TelemetriesFactory {

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method creates a certain number of records with an assigned
     * created date and saves them in the database
     * @Task: Task 5
     * @param numberTelemetries The number of telemetries that will be generated
     * @param CreatedDateTest The date when telemetries will be created
     * @return List<Telemetry__c> List with telemetries with the specified created date
     **/
    public static List<Telemetry__c> createTelemetryInsert(Integer numberTelemetries, DateTime CreatedDateTest){
        List<Telemetry__c> telemetryList = new List<Telemetry__c>();
        
        for(Integer i = 0; i <  numberTelemetries ; i++) {
            Telemetry__c telemetry = TelemetriesFactory.createTelemetry();
            telemetry.Name = telemetry.Name + i;
            telemetryList.add(telemetry);
        }
        
        insert telemetryList;
        
        for (Telemetry__c telemetry : telemetryList){
            Test.setCreatedDate(telemetry.id, CreatedDateTest);
        }
        
        return telemetryList;   
    }

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 01/09/2021
     * @description This method creates one telemetry with an assigned
     * name
     * @Task: Task 5
     * @return Telemetry__c Telemetry object with test name
     **/
    public static Telemetry__c createTelemetry(){  
        Telemetry__c telemetry = new Telemetry__c( Name = Constants.TELEMETRY_TEST_NAME);
         
        return telemetry;   
    }
}