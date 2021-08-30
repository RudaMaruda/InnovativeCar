/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 26/08/2021
* @description This class is responsible for sending the e-mail
**/
public class EmailClass {

  /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 26/08/2021
     * @description This method sends an email with the specified parameters
     **/  
  public static void SendEmailNotification(String adressEmail, String subject, String body) {  
       
     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();    
     mail.setToAddresses(new string[] {adressEmail});  
     mail.setSenderDisplayName(Constants.SENDER_DISPLAY);  
     mail.setSubject(subject);  
     mail.setHtmlBody(body); 
       
     Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail } );  
   }
}