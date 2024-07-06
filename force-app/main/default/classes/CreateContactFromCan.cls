public with sharing class CreateContactFromCan {
    
    public static void createContact (List<Candidate__c> candsFromTrigger){
        
   
        List <Account> candAccts = [SELECT Id, Name FROM Account WHERE Name = 'Recruiting'];
       
        List<Contact> conList = new List<Contact>();
        
   
        for(Candidate__c currentCandidate:candsFromTrigger){
        
            conList.add(new Contact (AccountId = candAccts[0].id,
                FirstName = currentCandidate.First_Name__c,
                LastName = currentCandidate.Last_Name__c,
                Email = currentCandidate.Email__c)
        );
    }
    
    Database.insert(conList);
    }
}