global class SendEmailFutureClass {
    @future
    public static void sendEmailToSalesDir(String adressEmail, String subject, String body){
        System.debug('Hello from SendEmailFutureClass');
        EmailClass.SendEmailNotification(adressEmail,subject,body);
    }

}