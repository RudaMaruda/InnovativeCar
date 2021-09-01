/**
* @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
* @date 27/08/2021
* @description This class creates account records
**/
@isTest
public class AccountFactory {
    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 27/08/2021
     * @description This method creates one account record
     * @Task: Task 4 & 5
     * @return Account One account with the specified name
     **/
    public static Account getSimpleAccount(){
        Account account = new Account (Name = Constants.ACCOUNT_TEST_NAME);
        return account;
    }

    /**
     * @author Malgorzata Krawczyk <malgorzata.krawczyk@accenture.com>
     * @date 27/08/2021
     * @description This method creates a certain number of account records
     * @Task: Task 4 & 5
     * @param numberAccounts The number of accounts that will be generated 
     * @return List<Account> List with accounts with the specified unique names
     **/
    public static List<Account> createAccountList(Integer numberAccounts){
        List<Account> accountList = new List<Account>();

        for (Integer i = 0; i < numberAccounts; i++) {
            Account account = AccountFactory.getSimpleAccount(); 
            account.Name =  account.Name + i;
            accountList.add(account);
        }

        return accountList;  
    }
}
