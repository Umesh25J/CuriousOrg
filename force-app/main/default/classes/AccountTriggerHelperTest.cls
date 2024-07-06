@isTest
private class AccountTriggerHelperTest 
{
	/*@isTest
    static void duplicateaccountchecking()
    {
        Account acc=new Account();
        acc.Name='Umesh Jangid';
        insert acc;
        
        Account acc1 = new Account();
        acc1.Name='Umesh Jangid';

        Test.startTest();
        DataBase.SaveResult savelist=DataBase.insert(acc1,false);
        Test.stopTest();
        
        System.assert(!savelist.isSuccess());
        System.assert(savelist.getErrors().size()>0);
        System.assertEquals('Can\'t add account that has same name as Account in dataBase',savelist.getErrors()[0].getMessage());
    }
    @isTest
    static void reparentContactWhenNewAccountinserting()
    { 
        Account acc=new Account();
        acc.Name='Umesh Jangid';
        insert acc;
        Contact contct1=new Contact();
        contct1.lastname='Sharma';
        contct1.AccountId=acc.id;
        insert contct1;
        Contact contct2=new Contact();
        contct2.lastname='Choudhary';
        contct2.AccountId=acc.id;
        insert contct2;
        Account acc1=new Account();
        acc1.Name='Umesh Jangid';
        insert acc1;
        Account a1=[Select id From Account Where ID=:acc1.Id];
        contact c1=[Select accountid From contact Where Id=:contct1.Id  ];
        System.assertEquals(a1.id, c1.AccountId);
        contact c2=[Select accountid From contact Where Id=:contct2.Id  ];
        System.assertEquals(a1.id, c2.AccountId);
    }
    @isTest
    static void removeContactWhenAccountUpdating()
    {
        Account acc=new Account();
        acc.Name='Umesh Jangid';
        insert acc;
        Contact contct1=new Contact();
        contct1.lastname='Sharma';
        contct1.AccountId=acc.id;
        insert contct1;
        Contact contct2=new Contact();
        contct2.lastname='Choudhary';
        contct2.AccountId=acc.id;
        insert contct2;
        acc.Name='ramesh';
        update acc;
        
        contact c1=[Select accountid From contact Where Id=:contct1.Id  ];
        System.assertEquals(null, c1.AccountId);
        contact c2=[Select accountid From contact Where Id=:contct2.Id  ];
        System.assertEquals(null, c2.AccountId);
        
    }
    @isTest
    static void removeContactWhenAccountUpdating()
    {
        Account acc=new Account();
        acc.Name='Umesh Jangid';
        insert acc;
        
        Account a1=[select Sales_Rep__c from Account where id=:acc.Id];
        System.assertEquals('umesh jangid',a1.Sales_Rep__c );
    }*/
	@isTest
    static void removeContactWhenAccountUpdating()
    {
        Account acc=new Account();
        acc.Name='testing';
        acc.Sum_of_the_open_opportunities_amount__c=100001;
        
        Test.startTest();
        DataBase.SaveResult savelist=DataBase.insert(acc,false);
        Test.stopTest();
        
        Task t1=[SELECT Status FROM Task WHERE Whatid=:acc.Id];
        System.assertEquals('Not Started',t1.Status);
    }
}