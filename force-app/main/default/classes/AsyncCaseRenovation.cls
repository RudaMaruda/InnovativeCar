/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class have method which create a new case and  synchronized with the external renovation system
**/

public class AsyncCaseRenovation implements Queueable {
    private ID carDealershipId;
    
    public AsyncCaseRenovation(ID id) {
        this.carDealershipId = id;
    }

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description The method is preparing a new renovation case and sending an inquiry to the external renovation system to check
     * whether there are free renovation teams
     **/
    public void execute (QueueableContext context){
        CarsDealership__c carsDealership = [Select Id, Name From CarsDealership__c Where Id =:carDealershipId LIMIT 1];
        String subjectRenovation = 'Renovation Case';
        String subjectCase = subjectRenovation + carsDealership.Name;

        Case newCase = new Case( Subject = subjectCase, Status='New', Origin= 'Phone',CarsDealershipRel__c = carDealershipId);

        insert newCase;

        Http server = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        request.setMethod('POST');
        request.setBody(JSON.serialize(newCase)); 
        HttpResponse response = server.send(request);
        if(response.getStatusCode() == 201) {
            newCase.Status = 'Closed';
        } else {
            newCase.Status = 'Failed';
            String errorMessage = 'Error connecting';
            System.debug(LoggingLevel.ERROR,errorMessage);
        }
    }
}
