trigger LeadTrigger on Lead (after insert,before update) 
{
    //Assignment 6:-Write a trigger that will prevent a user from creating/updating a lead that already exist as a contact.
    // Use the lead/contacts email address to detect duplicates
    if(Trigger.isInsert || Trigger.isUpdate)
    {
        LeadTriggerHelper.cannotUpdateEmail(Trigger.new);
    }
}