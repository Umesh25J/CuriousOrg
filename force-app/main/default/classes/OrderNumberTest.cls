@isTest(SeeAllData=True)
private class OrderNumberTest {
	static testMethod void validateHelloWorld() {
		Test.startTest();
		Messaging.InboundEmail email = new Messaging.InboundEmail();
		Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
		Opportunity op = new Opportunity (Id='0062v00001CLZcIAAX',StageName='Closed Won');
		update op;
		//Opportunity op1 = new Opportunity (Id='0062v00001CLZcIAAX',Reservation_Number__c='#9871');
		//update op1;
		email.subject= 'USH Youth Programs Number – 0062S00000t7FCn has been Placed';
		email.plainTextBody=  'Order Number is #9871 Please Use it as a Reference' ;
		env.fromAddress='xyz@mirketa.com';
		Test.stopTest();
		OrderNumber ac = new OrderNumber();
		ac.handleInboundEmail(email, env );
	}
}