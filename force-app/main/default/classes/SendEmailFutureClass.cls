/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description TThis class has future method for sending e-mails
* @Task: Task 5
**/
global class SendEmailFutureClass {

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This future method sends an email with the specified parameters
     * @Task: Task 5
     * @param adressEmail The email address to which the email will be sent
     * @param subject Email subject
     * @param body Email body
     **/
    @future
    public static void sendEmailToSalesDirector(String adressEmail, String subject, String body){
        EmailClass.SendEmailNotification(adressEmail,subject,body);
    }
}