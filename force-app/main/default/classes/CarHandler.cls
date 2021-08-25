public class CarHandler {
    
    
    // this method have to be changed
    public static void carDeletion(List<Car__c> carList1){
        
        List<ReviewCarDeletion__c> newReview = new List<ReviewCarDeletion__c>();
        
        for (Car__c c :carList1){
            ReviewCarDeletion__c rcd = new ReviewCarDeletion__c(Name='Raport '+c.Name);
            
            rcd.ReportDeletion__c = 'Deletion car with name '+c.Name +' with brand '+c.Brand__c;
            newReview.add(rcd);
            
            
        }
        
        
        if(newReview.size()>0){
            
            insert newReview;
            
        }
        
        
        
        
    }
    
    
    
}