public with sharing class EmailMessageTriggerHandler {
    public static void beforeInsert(List<EmailMessage> emailList) {
        System.debug('Email--'+emailList);
        Set<Id> userIds = new Set<Id>();
        for (EmailMessage em : emailList) {
            userIds.add(em.CreatedById);
        }
    
        Map<Id, User> users = new Map<Id, User>([SELECT Id, IsActive FROM User WHERE Id IN :userIds]);
    
        for (EmailMessage em : emailList) {
            User user = users.get(em.CreatedById);
            if (user != null && !user.IsActive) {
                em.addError('Cannot send email because the user is inactive.');
            }
        }
        System.debug('Emailtext-'+emailList[0].TextBody);
        System.debug('Emailtext-'+emailList[0].HtmlBody);

    }
    public static void afterInsert(List<EmailMessage> emailList){
        List<case> updateCase = new List<Case>();
        //if(updateCase.size()>0){
            for(Case caseRec: [Select Id,Status From Case Where Id =: EmailList[0].ParentID]){
                if(caseRec.Status == 'Need Review - Unable to Find Order' && EmailList[0].Incoming){
                    caseRec.Status = 'Review Update';
                    updateCase.add(caseRec);
                }
            }
        //}
        update updateCase;
    }
}