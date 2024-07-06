@isTest
public class LeadEmailServiceTest 
{
	@isTest
    private static void testEmailService()
    {
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
      	email.fromAddress = 'apitesting2710@gmail.com';
      	email.plainTextBody = '{"Name": "Siddharth","Phone_no": 1234567888,"Email": "testing@gmail.com","Selected_Option": "More than 50 Lakhs"}';
      	LeadEmailService  testInbound=new LeadEmailService();
      	testInbound.handleInboundEmail(email, env);
        System.assertEquals([SELECT Email from Lead WHERE Email=:'testing@gmail.com' LIMIT 1].Email,'testing@gmail.com');
        email.plainTextBody = '{"Name": "Siddharth","Phone_no": 1234567889,"Email": "testing@gmail.com","Selected_Option": "More than 50 Lakhs"}';
        testInbound.handleInboundEmail(email, env);
        System.assertEquals([SELECT Email from Lead WHERE Email=:'testing@gmail.com' LIMIT 1].Email,'testing@gmail.com');
        
    }
}