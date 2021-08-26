/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description TThis class has future method for sending e-mails
**/
global class SendEmailFutureClass {

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This future method sends an email with the specified parameters
     **/
    @future
    public static void sendEmailToSalesDirector(String adressEmail, String subject, String body){
        EmailClass.SendEmailNotification(adressEmail,subject,body);
    }
}