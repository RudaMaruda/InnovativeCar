public class OldTelemetriesDeletion implements Database.Batchable<sObject>, Database.Stateful{
    
    Datetime d = Datetime.now().addDays(-1);
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            
            'SELECT ID, Name , CreatedDate FROM Telemetry__c WHERE CreatedDate < '+d.format('yyyy-MM-dd')+'T'+d.format('HH:mm')+':00.00Z');
        
    }
    
    public void execute(Database.BatchableContext bc, List<sObject> scope){ 
        delete scope;
        DataBase.emptyRecycleBin(scope);
    }
    public void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
                            JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = :bc.getJobId()];
    }
    
}