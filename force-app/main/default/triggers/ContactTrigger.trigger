trigger ContactTrigger on Contact (before insert,before update,after insert, after update,before delete, after delete,after undelete) 
{
    //Assignment 9:-Whenever a contact record is create/update with the checkbox ‘Contact Relationship’ marked as checked, 
    //a new Contact Relationship record should be created with the name of the owner of the Contact record. 
    //If already a Contact Relationship record related to that contact exists, then another record should not be created
    if(Trigger.isInsert && Trigger.isAfter)
    {
        ContactTriggerHelper.createContactRelationship(Trigger.new);
    }
    //Assignment 10:-When we change the owner of the Contact, then the owner will be automatically populated in the ‘Contact Relationship Name’ field.
    if(Trigger.isBefore)
    {
        ContactTriggerHelper.autoPopulateChangesInOwner(Trigger.new);
    }
    //Assignment 11:-When we delete the contact record, then Contact Relationship record related to it will be deleted automatically
    if(Trigger.isBefore )
    {
       ContactTriggerHelper.deletingContactRelationShipRecord(Trigger.new); 
    }
    //Assignment 12:-When we undelete the contact record, then Contact Relationship record will be undeleted automatically
    if(Trigger.isAfter && Trigger.isUndelete)
    {
        ContactTriggerHelper.undeleteContactRelationShipRecord(Trigger.new);
    }
}