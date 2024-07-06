public class LeadTriggerHelper 
{
	public static void cannotUpdateEmail(List<Lead> ledRecords)
    {       
    	List<String> newleadEmail=new List<String>();
        for(Lead allLeads:ledRecords)
    	{	
            newleadEmail.add(allLeads.email);	
    	} 
        List<Contact> existingContactEmail=new List<Contact>();
        existingContactEmail=[SELECT Email FROM Contact Where Email IN :newleadEmail];
        List<String> oldContactEmail=new List<String>();  
        for(Contact oldCon:existingContactEmail)
        {
            oldContactEmail.add(oldCon.email);
        }
        for(Lead newLead:ledRecords)
        {
            if(oldContactEmail.contains(newLead.Email))
            {
               newLead.addError('Can\'t add duplicate with same name');
            }
        }
    }
}