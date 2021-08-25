@isTest
public class CarsDealershipFactory {

    public static List<CarsDealership__c> createCarsDealershipInsert(Integer numCarsDealerships, String acctId){

        List<CarsDealership__c> lst_CarsDealership = new List<CarsDealership__c>();


        for (Integer i = 0; i < numCarsDealerships; i++) {


            CarsDealership__c carDealer = new CarsDealership__c(Name = 'Test CarsDealership '+i,
                                                            Cars_Dealership_City__c = 'Test City '+i,
                                                            Car_Type__c = 'passenger car',
                                                            Account__c = acctId,
                                                            Cars_Dealership_Street__c = 'Test Street '+i,
                                                            Cars_Dealership_Street_Number__c = (10+i),
                                                            Dealership_Website__c = 'www.test.com '+i);
            lst_CarsDealership.add(carDealer);
        }


        if(lst_CarsDealership.size()>0){
            insert lst_CarsDealership;
        }
        
        return lst_CarsDealership;
    }
    
}
