/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class have method which create a new case and  synchronized with the external renovation system
**/

public class AsyncCaseRenovation implements Queueable {
    private ID carDealershipId;
    
    public AsyncCaseRenovation(ID id) {
        this.carDealershipId = id;
    }

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description The method is preparing a new renovation case and sending an inquiry to the external renovation system to check
     * whether there are free renovation teams
     * @Task: Task 5
     **/
    public void execute (QueueableContext context){
        List<CarsDealership__c> carsDealershipList = new List<CarsDealership__c>([Select Id, Name From CarsDealership__c Where Id =:carDealershipId]);
        CarsDealership__c carsDealership = carsDealershipList.get(0);
        String subjectCase = Constants.SUBJECT_CASE_RENOVATION + carsDealership.Name;

        Case newCase = new Case(
            Subject = subjectCase,
            Status = Constants.CASE_STATUS_NEW,
            Origin = Constants.CASE_ORIGIN_PHONE,
            CarsDealershipRel__c = carDealershipId);

        insert newCase;

        Http server = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        request.setMethod('POST');
        request.setBody(JSON.serialize(newCase)); 
        HttpResponse response = server.send(request);
        if(response.getStatusCode() == 201) {
            newCase.Status = Constants.CASE_STATUS_CLOSED;
        } else {
            newCase.Status = Constants.CASE_STATUS_FAILED;
            System.debug(LoggingLevel.ERROR,Constants.ERROR_CONNECTING_MESSAGE);
        }
    }
}
