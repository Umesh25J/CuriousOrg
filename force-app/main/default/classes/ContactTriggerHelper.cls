public class ContactTriggerHelper 
{
	public static void createContactRelationship(List<Contact> contactRecords)
    {
        Set<Id> ids=new Set<Id>(); 
        for(Contact newAcc:contactRecords)
        {
            ids.add(newAcc.ownerid);
        }
        Map<ID,String> contOwnerName=new Map<ID,String>();
        List<User> username=new List<User>();
        username=[Select Id,Name From User where id in :ids];
        for(User users:username)
        {
          	 contOwnerName.put(users.id,users.Name);
        }
        List<Contact_Relationship__C> conRelRecord=new List<Contact_Relationship__C>();
        List<Contact> allContact=new List<Contact>([SELECT Id, Contact_Relationship__c,OwnerID,(Select Contact__c From Contact_Relationships__r) FROM Contact Where ID In :contactRecords]);
        for(Contact con:allContact)
        {
        	if(con.Contact_Relationship__c==true)
            {
                if(con.Contact_Relationships__r.isEmpty())
                {
                	Contact_Relationship__C newContRelation=new Contact_Relationship__C(name=contOwnerName.get(con.OwnerId),Contact__c=con.Id);
                	conRelRecord.add(newContRelation);
                }
            }
        }
        insert conRelRecord;  
    }    
    public static void autoPopulateChangesInOwner(List<Contact> contactRecords)
    { 
        List<Contact_Relationship__c> ContactRelationrecords=new List<Contact_Relationship__c>();
        List<Contact_Relationship__c> toaddContactRelation = new List<Contact_Relationship__c>();
        Map<Id,Contact_Relationship__c> oldContactRelation=new Map<Id,Contact_Relationship__c>();
        List<Contact> contactwithrelationrecords=[SELECT id,name,Contact_Relationship__c,(SELECT id FROM Contact_Relationships__r) FROM Contact WHERE Id In:contactRecords AND Contact_Relationship__c=true];
        Map<Id,Id> owneridwithContact= new Map<Id,Id>();
        ContactRelationrecords =[SELECT name,contact__c FROM Contact_Relationship__c WHERE Contact__c In:contactRecords];
        for(Contact_Relationship__c cr:ContactRelationrecords)
        {
            oldContactRelation.put(cr.contact__c,cr);
        }
        
        Set<Id> ownerid=new Set<Id>();
        for(Contact c:contactRecords)
        {
            owneridwithContact.put(c.Id,c.OwnerId);
            ownerid.add(c.OwnerId);
        }
        List<User> name=new List<User>();
        Map<Id,String> ownername=new Map<Id,String>();
        name=[select id,name from user where id in :ownerid];
        for(User u:name)
        {
            ownername.put(u.id,u.name);
            
        }
        for(Contact cr:contactwithrelationrecords)
        {
            if(cr.Contact_Relationships__r.isempty())
            {
                Contact_Relationship__c newrecord=new Contact_Relationship__c();
                newrecord.contact__c=cr.Id;
                newrecord.name=ownername.get(owneridwithContact.get(cr.Id));
                toaddContactRelation.add(newrecord);
            }
            else
            {
                Contact_Relationship__c toupdatecontactrelation=oldContactRelation.get(cr.id);
                toupdatecontactrelation.name=ownername.get(owneridwithContact.get(cr.Id));
                toaddContactRelation.add(toupdatecontactrelation);
            }
        }
        upsert toaddContactRelation;  
    }
    public static void deletingContactRelationShipRecord(List<Contact> contactRecords)
    {
        List<Contact_Relationship__c> ContactRelationrecords=new List<Contact_Relationship__c>();
        ContactRelationrecords =[SELECT name,contact__c FROM Contact_Relationship__c WHERE Contact__c In:contactRecords];
        List<Contact_Relationship__c> ContactRelationrecordstoDelete=new List<Contact_Relationship__c>();
        
        for(Contact_Relationship__c conRel:ContactRelationrecords)
        {
            ContactRelationrecordstoDelete.add(conRel);
        }
        delete ContactRelationrecordstoDelete;
    }
	public static void undeleteContactRelationShipRecord(List<Contact> contactRecords)
    {
        List<Contact> undeletedcontacts =new List<Contact>();
        undeletedcontacts=[SELECT id,name FROM Contact Where id In :contactRecords];
        List<Contact_Relationship__c> toundeletecontactrelation=new List<Contact_Relationship__c>();
        toundeletecontactrelation=[SELECT id,name FROM Contact_Relationship__c WHERE contact__c In:undeletedcontacts AND isDeleted = true ALL ROWS];
        undelete toundeletecontactrelation;
    }
    
}