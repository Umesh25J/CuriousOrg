public class ContactUtility {
    public static void viewContacts(){
        List<Contact> listOfContacts = [SELECT FirstName, LastName FROM Contact LIMIT 5];
        for (Contact con : listOfContacts){
            String fullName = 'First Name: ' + con.FirstName + ', Last Name: ' + con.LastName;
            system.debug(fullName);
        }
    }
    /*public static void creatingAndCheckingContactRelationship(List<Contact> contactRecords)
    {
        List<Contact_Relationship__c> ContactRelationrecords=new List<Contact_Relationship__c>();
        List<Contact_Relationship__c> toaddContactRelation = new List<Contact_Relationship__c>();
        Map<Id,Contact_Relationship__c> oldContactRelation=new Map<Id,Contact_Relationship__c>();
        List<Contact> contactwithrelationrecords=[SELECT id,name,Contact_Relationship__c,(SELECT id FROM Contact_Relationship__r)FROM Contact WHERE Id In:contactRecords AND Contact_Relationship__c=true];
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
            if(cr.Contact_Relationship__r.isempty())
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
        List<Contact_Relationship__c> ContactRelationrecordstoDelete=new List<Contact_Relationship__c>();
        ContactRelationrecords =[SELECT name,contact__c FROM Contact_Relationship__c WHERE Contact__c In:contactRecords];
        for(Contact_Relationship__c cr:ContactRelationrecords)
        {
            ContactRelationrecordstoDelete.add(cr);
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
    }*/
}