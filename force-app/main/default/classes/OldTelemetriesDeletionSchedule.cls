/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class implements schedulable and calls the class to remove old telemetry
* @Task: Task 5
**/
global class OldTelemetriesDeletionSchedule implements Schedulable {
    global void execute(SchedulableContext sc){
        OldTelemetriesDeletionBatch oldTelemetriesDeletionBatch = new OldTelemetriesDeletionBatch();
        Database.executeBatch(oldTelemetriesDeletionBatch);  
    }
}