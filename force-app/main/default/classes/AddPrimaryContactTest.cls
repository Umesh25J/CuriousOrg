@isTest
private class AddPrimaryContactTest 
{
    @isTest
    private static void testQueueableClass() 
    {
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<100; i++) {
            Account acc = new Account(Name='Test Account');
            if ( i<50 ) 
            {
                acc.BillingState = 'NY';
            } else 
            {
                acc.BillingState = 'CA';
            }
            accounts.add(acc);
        }
        insert accounts; 
        Contact contact = new Contact(FirstName='Rakesh', LastName='Sharma');
        insert contact;
        
        Test.startTest();
        Id jobId = System.enqueueJob(new AddPrimaryContact(contact, 'NY'));
        Test.stopTest();
            
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Contact.Account.BillingState = 'NY'];
        System.assertEquals(50, contacts.size(), 'Incorrect number of Contact records found');
    }
}