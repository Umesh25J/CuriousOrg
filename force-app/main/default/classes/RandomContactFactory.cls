public class RandomContactFactory 
{
	public static List<Contact> generateRandomContacts(Integer numConts, String lastNameq) {
        List<Contact> contcts = new List<Contact>();
        for(Integer i=0;i<numConts;i++) {
            Contact con = new Contact(FirstName='Test' + i,LastName=lastNameq);
            contcts.add(con);
        }
        insert contcts;
        return contcts;
    }
}