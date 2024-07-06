public with sharing class AccountContactServices /*extends DirectoryAbstract*/{
    public static List<Sobject> getParentChildRecords()
    {
        return [select Name,Id,Phone,Type,(Select Name,FirstName,LastName,Email,Phone from Contacts) from Account WITH SECURITY_ENFORCED];
    }
    public static List<Sobject> insertChildData(String childDataString)
    {
        List<Contact> contactList = (List<Contact>)System.JSON.deserializeStrict(childDataString, List<Contact>.Class);
        if(Schema.sObjectType.Contact.isCreateable())
        {
            Database.insert(contactList);
        }
        return contactList;
    }
    public static void deleteChildData(String childId)
    {
        Contact con=[SELECT Id FROM Contact WHERE Id=:childId WITH SECURITY_ENFORCED];
        if(Schema.sObjectType.Contact.isDeletable())
        {
            delete con;
        }
    }
}