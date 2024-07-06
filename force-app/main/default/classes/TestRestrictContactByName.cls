@isTest
public class TestRestrictContactByName 
{
	@isTest
    static void RestrictContactByName()
    {
        Contact newContact=new Contact();
        newContact.LastName='INVALIDNAME';
        insert newContact;
        
        Test.startTest();
        Database.SaveResult savelist=Database.insert(newContact);
        Test.stopTest();
        
        System.assert(!savelist.isSuccess());
        System.assert(savelist.getErrors().size() > 0);
        System.assertEquals('The Last Name INVALIDNAME is not allowed for DML',
                             savelist.getErrors()[0].getMessage());
    }
}