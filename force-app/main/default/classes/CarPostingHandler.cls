public class CarPostingHandler {
    
    public static void addCarPostingPhysical(List<Car_Posting__c> newCarPost1){
        
        for (Car_Posting__c c : newCarPost1){
            
        
            if(c.Type__c == 'Physical'){
                
                Id idCar = c.Car__c;
                
                List<Car_Posting__c> carList = [Select id, Car__c, CarsDealership__c From Car_Posting__c where Type__c='Physical' and Car__c =: idCar];
                
                if(carList.size()>0){
                    
                    Id carsDeal = carList.get(0).CarsDealership__c;
                    CarsDealership__c carD = [select id, name from CarsDealership__c where id =: carsDeal Limit 1];
                    c.AddError('Only one physical offer could exist! This car is already in CarDealership : '+carD.Name);
                    
                }
                
            }
            
            
            
        } 
    }
    
    
    public static void addCarPostingLimit(List<Car_Posting__c> newCarPost2){
        
        
    for (Car_Posting__c c : newCarPost2){
        
        
        Id idCarDealer = c.CarsDealership__c;
        
        CarsDealership__c cd = [SELECT Id,Car_Quantity__c FROM CarsDealership__c WHERE 
                                                id =: idCarDealer LIMIT 1];
        Decimal carQuant = cd.Car_Quantity__c;
        List<Car_Posting__c> carPostListExist = [SELECT Id,Name FROM Car_Posting__c 
                                                WHERE 
                                                CarsDealership__c =: idCarDealer];
        
        
       
        if ((carPostListExist.size()+1) > carQuant){
            c.AddError('Available only '+carQuant+' car posting!');
        }
    }
        
        
    }
    
    public static void sendEmailSalesDir(List<Car_Posting__c> newCarPost3){
        
        UserRole ur = [SELECT Id FROM UserRole WHERE Name='Director, Direct Sales' LIMIT 1];
        User userDir = [SELECT Id, Name, UserRoleId, email FROM User where UserRoleId =:ur.id LIMIT 1];
        String emailDir = userDir.email;
        String subject = 'Information about new car postings';
        String body = '';
        
        System.debug('from method sendEmailSalesDir');
        
        for(Car_Posting__c c : newCarPost3){
            
            body = body+'New carPosting with name: '+c.Name + ' was added. With type car posting '+c.Type__c+' . ';
        }
        System.debug('Body email: '+body);
        System.debug('Email sent to: '+ emailDir + ' with subject: '+subject);
        
        SendEmailFutureClass.sendEmailToSalesDir(emailDir,subject,body);
        
    }
    
    
    
    
}