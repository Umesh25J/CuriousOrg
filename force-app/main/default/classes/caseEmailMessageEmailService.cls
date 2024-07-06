global with sharing class caseEmailMessageEmailService implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        try{
            System.debug('Debug--'+email);
        } catch (Exception e) {  
            result.success = false;  
            result.message = 'Oops, I failed. Error : '+e.getMessage();  
        }  
      
        return result;
    }
    public static void toSendEmailWithTemplate(Id caseId) {
        // Query the Email Template
        EmailTemplate emailTemp = [SELECT Id, Subject, Body, HtmlValue 
                                   FROM EmailTemplate
                                   WHERE DeveloperName ='Appliance_Refund_Proceed'
                                   LIMIT 1];
        
        // Query the Contact
        Contact con = [SELECT ID, Email 
                       FROM Contact 
                       WHERE LastName = 'Jangid'  
                       AND Email != null  
                       LIMIT 1];
    
        if (emailTemp != null && con != null) {
            // Create the EmailMessage record
            EmailMessage emailMsg = new EmailMessage();
            emailMsg.Subject = emailTemp.Subject;
            //emailMsg.HtmlBody = emailTemp.HtmlValue;
            emailMsg.TextBody = emailTemp.Body;
            emailMsg.ParentId = caseId; // Link to the Case
            emailMsg.ToAddress = con.Email; // Automatically populated based on recipient
            emailMsg.FromAddress = 'umesh.bodacious@gmail.com'; // Automatically populated based on sender
            insert emailMsg; // Insert the EmailMessage record
    
            // Create the email message to send
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(emailTemp.Id);
            mail.setTargetObjectId(con.Id);
            mail.setSaveAsActivity(true); // Prevents the email from being saved as an activity
            // Set the References to specify the message IDs to which this email is a reply
            mail.setWhatId(caseId);
            mail.setReferences(emailMsg.MessageIdentifier);
            
            // Add the email to the list for sending
            List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
            mailList.add(mail);
    
            // Send the email
            if (!mailList.isEmpty()) {
                Messaging.sendEmail(mailList);
            }
        }
    }
}