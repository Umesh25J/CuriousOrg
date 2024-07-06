@TestVisible
global class OrderNumber implements Messaging.InboundEmailHandler {
	@TestVisible	
	global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
		Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
		String inputString= email.subject;
		String reser= email.plainTextBody;
		String sub=inputString.substringAfter('Number');
		String sub2=sub.substringBefore('has');
		sub2 = sub2.trim();
		String r1=reser.substringAfter('is');
		String r2=r1.substringBefore('Please');
		r2=r2.trim();
		r2=r2.replace('\n\n','');
		Opportunity op = [Select id, StageName from Opportunity where id=:sub2];
		//Opportunity op1 = [Select id,Reservation_Number__c from Opportunity where id=:sub2];
		// System.debug(r1);
		//System.debug(op1);
		op.StageName = 'Closed Won';
		//op1.Reservation_Number__c = r2;
		update op;
		//update op1;
		result.success = true;
		System.debug(result);
		return result;
	}
}