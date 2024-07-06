public class QueryContact {
    public static Id getContactID(String lastName, String title) {
        try {
            Contact myContact = Database.query(
                'SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1'
            );
            return myContact.Id;
        } catch (Exception ex) {
            return null;
        }
    }
    public static Id getContactIDWithBinds(Map<String, Object> bindVars) {
        String query = 'SELECT ID FROM Contact WHERE LastName = :lastName AND Title = :title LIMIT 1';
        List<Contact> contacts = Database.queryWithBinds(query, bindVars, AccessLevel.USER_MODE);
        if (contacts != null && !contacts.isEmpty()) {
            return contacts[0].Id;
        } else {
            return null;
        }
    }
    /*public static Id getContactIDWithBinds(Map<String, Object> bindVars) {
    //do not modify any code above this line
    //implement the logic that will use bindVars to retrieve the contact's ID
    Id contactsId = getContactID('Brian Dent','Mission Specialist - Neptune');
    String queryString =
    'SELECT Id ' +
    'FROM Contact ' +
    'Where Id = :contactsId';
    return Database.queryWithBinds(
    queryString,
    bindVars,
    AccessLevel.USER_MODE
    ).ID;
    }*/
}