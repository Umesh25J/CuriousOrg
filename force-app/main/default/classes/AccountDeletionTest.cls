@isTest  
private class AccountDeletionTest {  
      
    @isTest static void TestDeleteAccountWithOneOpportunity(){  
        
       /* List<Account> acc = new List<Account>();  
 			for(Integer i = 0; i < numAcc; i++)
 			{ 
 				Account a = new Account(Name = 'TestAccount - ' + i);  
 				acc.add(a);  
 			} */
        Account a = new Account(Name='Sample');  
        try{  
            insert a;  
        }catch(DMLException e){  
            System.debug(e.getMessage());  
        }  
          
        Opportunity o = new Opportunity(Name = a.Name+' Opportunity',  
                                        StageName = 'Prospecting',  
                                        closeDate = System.today().addMonths(1),  
                                        AccountId = a.Id);  
        try{  
            insert o;  
        }catch(DMLException e){  
            System.debug(e.getMessage());  
        }  
          
        Test.startTest();  
        Database.DeleteResult result = Database.delete(a, false);  
        Test.stopTest();  
          
        System.assert(!result.isSuccess());  
        System.assert(result.getErrors().size() > 0);  
        System.assertEquals('Cannot delete account with related opportunities', result.getErrors()[0].getMessage());  
     
    }  
      
}