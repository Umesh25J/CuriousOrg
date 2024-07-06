global class LeadEmailService implements Messaging.InboundEmailHandler 
{
    public class EmailParser
    {
        public String Name;
        public String Phone_no;
        public String Email;
        public String Selected_Option;
        public EmailParser parse(String json) 
        {
            return (EmailParser) System.JSON.deserialize(json, EmailParser.class);
        }
    }
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.Inboundenvelope envelope) {  
        
        Lead lead;  
        System.debug(email.plainTextBody);
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();  
        try 
        {
            EmailParser ep = new EmailParser();
            ep = ep.parse(email.plainTextBody);
            System.debug(ep);
            if ([select count() from Lead where Email =:ep.Email] == 0) 
            {  
                lead = new Lead();  
                lead.LastName = ep.Name;
                lead.Company='Not Known';
                lead.Email=ep.Email;
                //lead.Priority__c = 'medium';
                lead.LeadSource = 'PMS Landing Page';
                lead.Phone = ep.Phone_no;
                //lead.Investment_Amount__c = ep.Selected_Option;
                System.debug(lead);
                insert lead;  
            } 
            else 
            {  
                lead = [select Id from Lead where Email =:ep.Email];
                //lead.Investment_Amount__c = ep.Selected_Option;
                lead.Phone = ep.Phone_no;
                lead.LastName = ep.Name;
                update lead;
            } 
            result.success = true;  
            result.message = (email.subject + ' matched');  
        }
        catch (Exception e) 
        {  
            result.success = false;  
            result.message = 'Oops, I failed. Error : '+e.getMessage();  
        }  
        return result;  
    }  
}