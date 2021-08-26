/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class implements Batchable and applies to data that was created the day before yesterday
**/
public class OldTelemetriesDeletion implements Database.Batchable<sObject>, Database.Stateful{
    Datetime dateTimeDeletion = Datetime.now().addDays(-1);
    
    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method searches for lists of telemetry data that were created later than yesterday
     **/
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID,Name,CreatedDate FROM Telemetry__c WHERE CreatedDate < '+dateTimeDeletion.format('yyyy-MM-dd')+'T'+dateTimeDeletion.format('HH:mm')+':00.00Z');  
    }
    
    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method deletes the found old telemetry data
     **/
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