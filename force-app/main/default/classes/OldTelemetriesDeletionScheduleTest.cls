/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class has test methods for the scheduled classes
* @Task: Task 5
**/
@isTest
public class OldTelemetriesDeletionScheduleTest {

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This test checks scheduled classes
     **/
    @isTest
    static void testScheduler() {
        String cronExpr = '0 58 11 28 8 ? 2022';
        
        List<AsyncApexJob> jobsBefore = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob];
        String message = 'Not expecting any asyncjobs';
        System.assertEquals(0, jobsBefore.size(), message);
        
        Test.startTest();
        OldTelemetriesDeletionSchedule otd = new OldTelemetriesDeletionSchedule();
        String jobId = System.schedule('jobName', cronExpr, otd);
        Test.stopTest();
        
        String jobTypeSchedule = 'ScheduledApex';
        String messageSchedule = 'expecting one scheduled job';
        String messageScheduleSpecific = 'expecting specific scheduled job';
        String classScheduledName = 'OldTelemetriesDeletionSchedule';

        List<AsyncApexJob> jobsScheduled = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType =: jobTypeSchedule];
        System.assertEquals(1, jobsScheduled.size(), messageSchedule);
        System.assertEquals(classScheduledName, jobsScheduled[0].ApexClass.Name, messageScheduleSpecific);
        
        String jobTypeBatch = 'BatchApex';
        String messageBatch = 'expecting one apex batch job';
        String messageBatchSpecific = 'expecting specific batch job';
        String classBatchName = 'OldTelemetriesDeletionBatch';

        List<AsyncApexJob> jobsApexBatch = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType =: jobTypeBatch];
        System.assertEquals(1, jobsApexBatch.size(), messageBatch);
        System.assertEquals(classBatchName, jobsApexBatch[0].ApexClass.Name, messageBatchSpecific); 
    }
}