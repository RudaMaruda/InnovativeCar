@isTest
public  class TestCarPostingFactory {

    public static List<Car_Posting__c> createCarPostingPhysical(Integer numCarPostings,String idCar,String idCarDeal){

        List<Car_Posting__c> lst_CarPosting = new List<Car_Posting__c>();


        for (Integer i = 0; i < numCarPostings; i++) {

            Car_Posting__c carPost = new Car_Posting__c(Car__c = idCar,
            CarsDealership__c = idCarDeal,
            Type__c = 'Physical');
           
            lst_CarPosting.add(carPost);
        }

        if(lst_CarPosting.size()>0){
            insert lst_CarPosting;  
        }
        
        return lst_CarPosting;
    }
    
}
