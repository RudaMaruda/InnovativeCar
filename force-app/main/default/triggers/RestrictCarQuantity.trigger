trigger RestrictCarQuantity on CarsDealership__c (before insert, before update) {
    
    for (CarsDealership__c c: Trigger.new){
        if(c.Car_Quantity__c <= 0){
            c.AddError('Car Quantity must be above 0!');
        }
    }

}