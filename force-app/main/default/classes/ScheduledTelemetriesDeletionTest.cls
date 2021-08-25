@isTest
public class ScheduledTelemetriesDeletionTest {
    
    
    @isTest static void testScheduler () {
        
        String cronExpr = '0 58 11 28 8 ? 2022';
        
              
        
        List<AsyncApexJob> jobsBefore = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob];
        System.assertEquals(0, jobsBefore.size(), 'not expecting any asyncjobs');
        
        Test.startTest();
        ScheduledOldTelemetriesDeletion otd = new ScheduledOldTelemetriesDeletion();
        String jobId = System.schedule('jobName', cronExpr, otd);
        Test.stopTest();
        
        List<AsyncApexJob> jobsScheduled = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'ScheduledApex'];
        System.assertEquals(1, jobsScheduled.size(), 'expecting one scheduled job');
        System.assertEquals('ScheduledOldTelemetriesDeletion', jobsScheduled[0].ApexClass.Name, 'expecting specific scheduled job');
        
        
        List<AsyncApexJob> jobsApexBatch = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'BatchApex'];
        System.assertEquals(1, jobsApexBatch.size(), 'expecting one apex batch job');
        System.assertEquals('OldTelemetriesDeletion', jobsApexBatch[0].ApexClass.Name, 'expecting specific batch job');
        
    }
    
    
}