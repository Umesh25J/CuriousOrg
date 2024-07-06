trigger Assign5 on Account (after insert,after Delete) 
{
    /*if(trigger.isafter)
    {
        String str;
        for(Account b:trigger.new)
        {
            str=b.Name;            
        }
        Account a=[SELECT (SELECT LastName FROM Contacts) FROM Account WHERE Id IN (SELECT AccountId FROM Contact ) AND Name=:str LIMIT 1 OFFSET 0];
        lname=a.
    }
    String newName,lname,oldname;
    for(Account a: Trigger.New)
    {
        newName=a.name;
        
    }
    Account O=[select Name From Account where name=:newName];
    delete O;
    for(Account Oldacc:Trigger.old)
    {
        oldname=Oldacc.Name;
        Contact c = new Contact(AccountId = [SELECT Name FROM Account WHERE name=:oldname LIMIT 1].Id);  
        c.LastName='Aman';
        //c.LastName = [Select (Select LastName from Contacts) from Account WHERE Name=:oldname];
        insert c;
    } */
}