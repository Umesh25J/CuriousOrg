@isTest
private class LeadTriggerHelperTest 
{
	@isTest
    static void leadEmailCannotDublicate()
    {
        Contact c1=new Contact();
        c1.LastName='jangid';
        c1.Email='umesh484@gmail.com';
        insert c1;
        
        Lead l1= new Lead();
        l1.Email='umesh484@gmail.com';
        l1.lastname='Jangid';
        l1.Company='xyz';
        l1.status='Open - Not Contacted';        
        
        Test.startTest();  
        Database.SaveResult result = Database.insert(l1, false);  
        Test.stopTest();  
          
        System.assert(!result.isSuccess());  
        System.assert(result.getErrors().size() > 0);  
        System.assertEquals('Can\'t add duplicate with same name', result.getErrors()[0].getMessage());  
    }
}