global class ProcessLeadApplicantEmail implements Messaging.InboundEmailHandler {
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          
          Lead led=new Lead();
          // led.FirstName = email.fromname.substring(0,email,fromname.indeOf(''));
          // led.LastName = email.fromname.substring(email,fromname.indeOf(''));
          led.Company = led.FirstName+ '' + led.LastName;
          led.Email = envelope.fromAddress;
          insert led;
          
          System.debug('===> Created contact==>'+contact.Id);
          
          if(email.binaryAttachments != null && email.binaryAttachments.size() > 0){
              for(integer i=0;i<email.binaryAttachments.size();i++){
                  Attachment attachment=new Attachment();
                  //attach to newly created contact record
                  attachment.ParentId=led.Id;
                  attachment.Name=email.binaryAttachments[i].filename;
                  attachment.Body=email.binaryAttachments[i].body;
                  insert attachment;
              }
          }
          return result;
      }
  }