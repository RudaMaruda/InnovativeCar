trigger CarPostingNew1 on Car_Posting__c (before insert, before update) {


// Michal please check this trigger

List<Id> listId = new List<Id>();
for (Car_Posting__c c : Trigger.new){
    listId.add(c.CarsDealership__c);
}

    List<Car_Posting__c> carPostListExist = [SELECT Id,Name FROM Car_Posting__c 
                                            WHERE 
                                            CarsDealership__c IN :listId AND
                                            Type__c = 'Physical'];

    
for (Car_Posting__c c : Trigger.new){
    


    if (carPostListExist.size() > 0 && c.Type__c == 'Physical'){
        c.AddError('Only one phyical offer could exist!');
    }
}

}