/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class implements schedulable and calls the class to remove old telemetry
**/
global class ScheduledOldTelemetriesDeletion implements Schedulable {
    global void execute(SchedulableContext sc){
        OldTelemetriesDeletion oldTelemetriesDeletion = new OldTelemetriesDeletion();
        Database.executeBatch(oldTelemetriesDeletion);  
    }
}