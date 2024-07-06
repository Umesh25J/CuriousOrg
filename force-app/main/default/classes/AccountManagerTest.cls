@IsTest
private class AccountManagerTest {
    @isTest static void testGetContactsByAccountid(){
        Id recordId=createTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI = 
            'https://yourInstance.salesforce.com/services/apexrest/Accounts/'+recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
    }
    static ID createTestRecord(){
        Account accountTest = new Account(
        Name='Test record');
        insert accountTest;
        
        Contact contactTest =new Contact(
        FirstName='John',
            LastName='Doe',
            AccountId=accountTest.Id);
        insert contactTest;
        return accountTest.Id;
    }
}