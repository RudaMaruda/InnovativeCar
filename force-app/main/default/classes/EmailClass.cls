public class EmailClass {
    
    public static void SendEmailNotification(String adressEmail, String subject, String body) {  
       
     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();  
      
     mail.setToAddresses(new string[] {adressEmail});  
     mail.setSenderDisplayName('Email');  
     mail.setSubject(subject);  
     mail.setHtmlBody(body); 
        
        System.debug('Hello from EmailClass');
       
     Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail } );  
   }

}