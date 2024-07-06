global class EmailToSalesForce implements Messaging.InboundEmailHandler {  
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.Inboundenvelope envelope) {
      Lead lead;  
      Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();  
      try {  
            System.debug(email);
          	// Look for account whose name is the subject and create it if necessary  
          	if ([select count() from Lead where Name =:email.subject] == 0) {  
              	lead = new Lead();  
              	lead.LastName = email.subject;
              	lead.Company='Web to lead';
                lead.Email=email.fromAddress;
              	insert lead;  
          	} else {  
              	lead = [select Id from Lead where Name =:email.subject];  
          	}  
         
          if(email.textAttachments != null)  
          {  
              // Save attachments, if any  
              for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {  
                  Attachment attachment = new Attachment();  
                  attachment.Name = tAttachment.fileName;  
                  attachment.Body = Blob.valueOf(tAttachment.body);  
                  System.debug(attachment.Body);
                  Blob csvBlob =Blob.valueOf(tAttachment.body);
                  System.debug(csvBlob);
                  String s = EncodingUtil.base64Encode(csvBlob);
 				  System.debug(s);
                  string s1 = EncodingUtil.base64Decode(s).toString(); 
        		  System.debug(s1);
                  attachment.ParentId = lead.Id;  
                  insert attachment;  
              }  
          }  
          if(email.binaryAttachments != null)  
          {  
              for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {  
                  Attachment attachment = new Attachment();  
                  attachment.Name = bAttachment.fileName;  
                  attachment.Body = bAttachment.body;  
                  attachment.ParentId = lead.Id;  
                  insert attachment;  
              }  
          }  
          result.success = true;  
          result.message = (email.subject + ' matched');  
      } catch (Exception e) {  
          result.success = false;  
          result.message = 'Oops, I failed. Error : '+e.getMessage();  
      }  
        
      return result;  
  }  
}