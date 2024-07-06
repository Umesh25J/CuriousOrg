trigger Assign4 on Account (before insert) 
{
    
    /*for(Account a : Trigger.New) {
        if(a.Name!=null)
        {
        a.Description = 'New description'; 
    }
        }
     //To store parent ids
    list<id> AccountIds=new list<id>();
    for(Account accountVar:trigger.old)
    {
        AccountIds.add(accountVar.id);
    }  
    //Collecting all child records related to Parent records
    list<contact> listOfContacts=[select id from Contact where accountid in :AccountIds];
    system.debug('listOfContacts'+listOfContacts);
    //deleting child records
    delete listOfContacts;

if(trigger.isafter)
    {
        Account acc=[Select Name From Account ];1
        String str,lname,fname;
        List<ID> lid=new List<Id>();
        for(Account b:trigger.new)
        {
            str=b.Name;
            lid.add(b.Id);            
        }
        Account a=[SELECT (SELECT LastName FROM Contacts) FROM Account WHERE Id IN (SELECT AccountId FROM Contact ) AND Name=:str LIMIT 1 OFFSET 0];
        Contact c=[SELECT lastname,firstname FROM Contact where account.id=:a.Id];
        //lname=c.LastName;
        //fname=c.FirstName;
        Contact cc=new Contact();
        cc.AccountId=([SELECT Name from account where name=:str limit 1].id);
        cc.LastName=c.LastName;
        cc.FirstName=c.FirstName;
        insert cc;
        //delete a;
    }
    trigger CreateAutoAccountFromContact on Contact (before insert, after insert){  
    if(trigger.isBefore){
        system.debug('trigger before event');
        if(trigger.isInsert){            
            
            List<Contact> listOfContact = new List<Contact>();            
            
            for (Contact conObj : trigger.new)   
            {  
                if (String.isBlank(conObj.accountid))   
                {  
                    listOfContact.add(conObj);  
                }  
            }  
            system.debug('listOfContact_1 ' + listOfContact);  
            
            if (listOfContact.size() > 0)
            {  
                List<Account> createNewAcc = new List<Account>();
                Map<String,Contact> conNameKeys = new Map<String,Contact>();
                
                for (Contact con : listOfContact)   
                {  
                    String accountName = con.firstname + ' ' + con.lastname;  
                    conNameKeys.put(accountName,con);                      
                    Account accObj = new Account();  
                    accObj.Name = accountName;
                    accObj.Phone= con.MobilePhone;
                    createNewAcc.add(accObj);  
                }  
                Insert createNewAcc;  
                for (Account acc : createNewAcc)   
                {  
                    system.debug('mapContainsKey ' + conNameKeys.containsKey(acc.Name));
                   
                    if (conNameKeys.containsKey(acc.Name))   
                    {  
                        conNameKeys.get(acc.Name).accountId = acc.Id;  
                    }  
                }  
            } 
        }
    }
    else if(trigger.isAfter){
        system.debug('trigger after event');
    }
    
}   
*/

}