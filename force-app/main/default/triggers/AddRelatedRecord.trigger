trigger AddRelatedRecord on Account(after insert, after update) {
   /*
    List<Contact> oppList = new List<Contact>();
    List<Contact> contList = new List<Contact>();
    contList=[Select AccountID From Contact];
    System.debug(contList);
    
    List <Account> oldAcct=new List<Account>();
    // Get the related Contacts for the accounts in this trigger
    Map<Id,Account> acctsWithConts = new Map<Id,Account>([SELECT Id,(SELECT AccountID,Name FROM Contacts) FROM Account ]);
    System.debug(acctsWithConts.values());
    list<String> existingAcctNames=new list<String>();
    // Add an Contacts for each account if it doesn't already have one.
    // Iterate through each account.
    for(Account a : Trigger.New)
    {
        System.debug('acctsWithConts.get(a.Id).Contacts.size()=' + acctsWithConts.get(a.Id).Contacts.size());
        // Check if the account already has a related Contact.
        existingAcctNames.add(a.Name);
        if (acctsWithConts.get(a.Id).Contacts.size() == 0) 
        {
            // If it doesn't, add a default opportunity
            oppList.add(new Contact(AccountId=a.Id,Lastname='jaat'));
        }           
    }
    System.debug(existingAcctNames);
    oldAcct=[Select Name,(Select AccountID,Name From Contacts) From Account Where Name In :existingAcctNames];
    System.debug(oldAcct);
    if (oppList.size() > 0) 
    {
        insert oppList;
    }*/
}