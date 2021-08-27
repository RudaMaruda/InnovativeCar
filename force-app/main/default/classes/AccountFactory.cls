/**
* @author name <malgorzata.krawczyk@accenture.com>
* @date 27/08/2021
* @description This class creates account records
**/
@isTest
public class AccountFactory {
    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 27/08/2021
     * @description This method creates one account record
     **/
    public static Account getSimpleAccount(){
        String accountName = 'Test Account';
        Account account = new Account (Name = accountName);
        return account;
    }

    /**
     * @author name <malgorzata.krawczyk@accenture.com>
     * @date 27/08/2021
     * @description This method creates a certain number of account records
     **/
    public static List<Account> createAccountList(Integer numberAccounts){
        List<Account> accountList = new List<Account>();

        for (Integer i = 0; i < numberAccounts; i++) {
            String accountName = 'Test Account ' + i;
            Account account = new Account (Name = accountName); 
            accountList.add(account);
        }

        return accountList;  
    }
}
