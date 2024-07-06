trigger reparentContact on Account (after insert, after update) 
{
    /*List <Contact> cntLstOld = new List<Contact>();    
    List <Account> oldAcct=new List<Account>();
    List <String> existingAcctNames=new List<String>();
    List <Contact> contactToUpdate=new List<Contact>();
    Map <String,ID> accNew=new Map<String,ID>();
    List <ID> accIds=new List <ID>();
    //Map <ID,Account> accToUpdate=new Map<ID,Account>();
    for(Account a:Trigger.new)
    {
        accNew.put(a.name,a.id);
        existingAcctNames.add(a.name);
        accIds.add(a.Id);
        //accToUpdate.put(a.ID,a);
    }
    System.debug(existingAcctNames);
    System.debug(accIds);
    //System.debug(accToUpdate);
    oldAcct=[Select Name,(Select AccountID,Name From Contacts) From Account Where Name In :existingAcctNames AND ID NOT IN :Trigger.new];
    cntLstOld=[SELECT Id, AccountId, LastName, Account.Name FROM Contact where Account.Name In :existingAcctNames];
    System.debug(oldAcct);
    System.debug(cntLstOld);
    for(Account b:oldAcct)
    {   
        for(Contact con:cntLstOld)
        {
            id idNew=accNew.get(b.name);
            con.accountID=idNew;
            contactToUpdate.add(con);
            //accToUpdate.put(con.accountID,accToUpdate.get(con.accountID));
        }   
    }
    update contactToUpdate;
    delete oldAcct;
    System.debug(contactToUpdate);
    System.debug(cntLstOld);
    //if(!accToUpdate.values().isEmpty())
    //{
        //update cntLst;
        //update accToUpdate.values();
    //}*/
}