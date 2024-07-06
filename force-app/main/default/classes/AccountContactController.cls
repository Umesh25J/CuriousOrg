public with sharing class AccountContactController
{
    /*@AuraEnabled 
    public static List<Account> getAccountContactRecords(){
        AccountContactServices acs = new AccountContactServices();
        return acs.getParentChildRecords();
    }
    @AuraEnabled
    public static List<Contact> insertContactData(String contactDataString){
        AccountContactServices acs = new AccountContactServices();
        return acs.insertChildData(contactDataString);
    }
    @AuraEnabled
    public static void deleteContactData(String conId){
        AccountContactServices acs = new AccountContactServices();
        acs.deleteChildData(conId);
    }*/

    @AuraEnabled 
    public static List<Account> getAccountContactRecords()
    {
        return [select Name,Id,Phone,Type,(Select Name,FirstName,LastName,Email,Phone from Contacts) from Account WITH SECURITY_ENFORCED];
    }
    @AuraEnabled 
    public static List<Contact> insertContactData(String childDataString)
    {
        List<Contact> contactList = (List<Contact>)System.JSON.deserializeStrict(childDataString, List<Contact>.Class);
        if(Schema.sObjectType.Contact.isCreateable())
        {
            Database.insert(contactList);
        }
        return contactList;
    }
    @AuraEnabled 
    public static void deleteContactData(String childId)
    {
        Contact con=[SELECT Id FROM Contact WHERE Id=:childId WITH SECURITY_ENFORCED];
        if(Schema.sObjectType.Contact.isDeletable())
        {
            delete con;
        }
    }
}