@isTest
public class ContactTriggerHelperTest
{
	@isTest
    static void createRelationShipToContact()
    {
        Contact newCon=new Contact();
        newCon.lastname='rakesh ju';
        newCon.Contact_Relationship__c=true;
        insert newCon;
        
        newCon.Contact_Relationship__c=false;
        update newCon;
        
        newCon.Contact_Relationship__c=true;
        update newCon;
        
        Contact_Relationship__C conrel=[Select name From Contact_Relationship__C where Contact__C =:newCon.id ];
        System.assertEquals('umesh jangid',conrel.name );
    }
    @isTest
    static void autoPopulateChangesOnOwner()
    {
        Contact newCon=new Contact();
        newCon.lastname='rakesh ju';
        newCon.Contact_Relationship__c=true;
        insert newCon;
        newCon.OwnerId='0055j000003RMijAAG';
        upsert newCon;
	}
     @isTest
    static void deletingContactRelationShip()
    {
         
       
        Contact newCon=new Contact();
        newCon.lastname='rakesh juaSDAsd';
        newCon.Contact_Relationship__c=true;
        Contact_Relationship__c newCr=new Contact_Relationship__c();
        newCr.Contact__c=newCon.id;
        try{  
            insert newCon;
            insert newCr;
        }catch(DMLException e){  
            System.debug(e.getMessage());  
        } 
        
        Test.startTest();
        Database.DeleteResult result = Database.delete(newCon,false);
        Test.stopTest();
        
	}
    @isTest
    static void undeleteContactRelationShipRecord()
    {
        Contact newCon=new Contact();
        newCon.lastname='rakesh juaSDAsd';
        newCon.Contact_Relationship__c=true;
        Contact_Relationship__c newCr=new Contact_Relationship__c();
        newCr.Contact__c=newCon.id;
        try{  
            insert newCon;
            insert newCr;
			delete newCon;
        }catch(DMLException e){  
            System.debug(e.getMessage());  
        } 
        Test.startTest();
        Database.UndeleteResult result = Database.undelete(newCon,false);
        Test.stopTest();
	}
}
/*@isTest
private class ContactTriggerHelperTest
{
    @isTest
    static void creatingContactRelationship()
    {
        Contact contactRecord=new Contact();
        contactRecord.LastName='Testing Contact';
        contactRecord.Contact_Relationship__c=true;
        
        insert contactRecord;
        
        Contact_Relationship__c cr=[SELECT name FROM Contact_Relationship__c WHERE contact__c=:contactRecord.Id];
        
        System.assertEquals('mark salesforce',cr.name);
    }
    @isTest
    static void updatingContactRelationshipName()
    {
        Contact contactRecord=new Contact();
        contactRecord.LastName='Testing Contact';
        contactRecord.Contact_Relationship__c=true;
        contactRecord.OwnerId='0055i000000sHcaAAE';
        
        insert contactRecord;
        
        contactRecord.OwnerId='0055i000002RSshAAG';
        
        update contactRecord;
        
        Contact_Relationship__c cr=[SELECT name FROM Contact_Relationship__c WHERE contact__c=:contactRecord.Id];
        
        System.assertEquals('testingUser',cr.name);
    }
    @isTest
    static void deleteContactRelationshipRecord()
    {
        Contact contactRecord=new Contact();
        contactRecord.LastName='Testing Contact';
        contactRecord.Contact_Relationship__c=true;
        contactRecord.OwnerId='0055i000000sHcaAAE';
        
        insert contactRecord;
        
        List<Contact_Relationship__c> crRecord=[SELECT name FROM Contact_Relationship__c WHERE contact__c=:contactRecord.Id];
        System.assertEquals(1,crRecord.size());
        
        delete contactRecord;
        
        List<Contact_Relationship__c> cr=[SELECT name FROM Contact_Relationship__c WHERE contact__c=:contactRecord.Id];
        System.assertEquals(0,cr.size());
    }
        @isTest
    static void undeleteContactRelationshipRecord()
    {
        Contact contactRecord=new Contact();
        contactRecord.LastName='Testing Contact';
        contactRecord.Contact_Relationship__c=true;
        contactRecord.OwnerId='0055i000000sHcaAAE';
        
        insert contactRecord;
        
        List<Contact_Relationship__c> crRecord=[SELECT name FROM Contact_Relationship__c WHERE contact__c=:contactRecord.Id];
        System.assertEquals(1,crRecord.size());
        
        delete contactRecord;
        
        List<Contact_Relationship__c> cr=[SELECT name FROM Contact_Relationship__c WHERE contact__c=:contactRecord.Id];
        System.assertEquals(0,cr.size());
        
        undelete contactRecord;
        
        List<Contact_Relationship__c> crRecords=[SELECT name FROM Contact_Relationship__c WHERE contact__c=:contactRecord.Id];
        System.assertEquals(1,crRecords.size());
    }
}trigger ContactTrigger on Contact (after insert,after update,before delete,after undelete) 
{
    
    if(Trigger.isinsert ||Trigger.isupdate)
    {
       ContactTriggerHelper.creatingAndCheckingContactRelationship(Trigger.new);
    }
    if(Trigger.isdelete)
    {
        ContactTriggerHelper.deletingContactRelationShipRecord(Trigger.old);
    }
    if(Trigger.isUndelete)
    {
        ContactTriggerHelper.undeleteContactRelationShipRecord(Trigger.new);
    }
}*/