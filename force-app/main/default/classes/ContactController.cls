global with sharing class ContactController {
    public List<Contact> contacts {get;set;}
    public Id selectedContactId {get;set;}
    public Contact selectedContact {get;set;}
    
    public ContactController() {
        contacts = [SELECT Id, FirstName, LastName, Email FROM Contact];
    }
    
    public void updateSelectedContactId(Id contactId) {
        selectedContactId = contactId;
        selectedContact = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Id = :contactId];
    }
    
    public Boolean getShowModal() {
        return selectedContactId != null;
    }
    
    @RemoteAction
    global static void updateContact(String contactId, String firstName, String lastName, String email) {
        Contact c = new Contact(Id = contactId, FirstName = firstName, LastName = lastName, Email = email);
        update c;
    }
}