global class ScheduledOldTelemetriesDeletion implements Schedulable {
    
    global void execute(SchedulableContext sc){
        
        OldTelemetriesDeletion otd = new OldTelemetriesDeletion();
        Database.executeBatch(otd);
        
    }
    
}