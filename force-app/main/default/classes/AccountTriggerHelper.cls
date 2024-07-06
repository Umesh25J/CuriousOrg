public class AccountTriggerHelper 
{
    /*public static void duplicateAccountsCheck(List<Account> accountRecords)
    {
        Set<String> newAccountName=new Set<String>();
        for(Account acc:accountRecords)
        {
            newAccountName.add(acc.name);      
        }
        List<Account> oldAccountWithSameName=[SELECT id,name FROM Account WHERE name IN : newAccountName];
        List<String> oldAccountName=new List<String>();
        for(Account acc:oldAccountWithSameName)
        {
            oldAccountName.add(acc.Name);
        }
        for(Account acc:accountRecords)
        {
            if(oldAccountName.contains(acc.Name))
            {
                acc.addError('Can\'t add account that has same name as Account in dataBase');
            }
        }
    }/public static void reparentContactWhenAccountInsertedwithSameName(List<Account> accountsRecord)
    {
        List <Contact> cntLstOld = new List<Contact>();    
		List <Account> oldAcct=new List<Account>();
		List <String> existingAcctNames=new List<String>();
		List <Contact> contactToUpdate=new List<Contact>();
		Map <String,ID> accNew=new Map<String,ID>();
		List <ID> accIds=new List <ID>();
		for(Account a:accountsRecord)
		{
			accNew.put(a.name,a.id);
			existingAcctNames.add(a.name);
			accIds.add(a.Id);
		}
		oldAcct=[Select Name,(Select AccountID,Name From Contacts) From Account Where Name In :existingAcctNames AND ID NOT IN :accountsRecord];
		cntLstOld=[SELECT Id, AccountId, LastName, Account.Name FROM Contact where Account.Name In :existingAcctNames];
		for(Account b:oldAcct)
		{	
			for(Contact con:cntLstOld)
			{
				id idNew=accNew.get(b.name);
				con.accountID=idNew;
				contactToUpdate.add(con);
			}   
		}
		update contactToUpdate;
		delete oldAcct;
    }
    public static void removeContactWhenAccountUpdate(List<Account> accountRecord)
    {
        List<Account> AccList =new List<Account>();
        List<Contact> conAc=new List<Contact>();
        AccList=accountRecord;   
        for(Account acc:AccList)
        {
            for(Contact conList:[Select Id, Name, FirstName, LastName, AccountId From Contact Where AccountId=:acc.Id])
            {
                conList.AccountId=null;
                conAc.add(conList);
            }    
        }
        update conAc;
    } 
    public static void accountOwnerAddedtoSalesRep(List<Account> accountRecord)
    {
        Map<ID,String> contOwnerName=new Map<ID,String>();
        Set<Id> ids=new Set<Id>(); 
        for(Account newAcc:accountRecord)
        {
            ids.add(newAcc.ownerid);
        }
        List<User> username=new List<User>();
        username=[Select Id,Name From User where id in :ids];
        for(User users:username)
        {
          	 contOwnerName.put(users.id,users.Name);
        }
        for(Account nameAssign:accountRecord)
        {
        	nameAssign.Sales_Rep__c=contOwnerName.get(nameAssign.OwnerId);
        } 
    */
  	public static void CreateTaskForAccount(List<Account> accountRecord)
    {	
        //List for new task associated to account when Sum_of_the_open_opportunities_amount__c greater than 100000 to add 
        List<Task> TaskToInsert=new List<Task>();
        //Loop for Account to create new task when Sum_of_the_open_opportunities_amount__c greater than 100000
        for(Account acc:accountRecord)
        {
            //Check for account field Sum_of_the_open_opportunities_amount__c greater than 100000
            if(acc.Sum_of_the_open_opportunities_amount__c>100000)
            {
                //New task assigning to associated account 
                Task newtask=new Task();
                newtask.WhatId=acc.id;
                newtask.OwnerId=acc.OwnerId;
                newtask.Status='Not Started';
                TaskToInsert.add(newTask);
            }
        }
        insert TaskToInsert;
    }    
}