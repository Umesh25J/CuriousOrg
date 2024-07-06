global class UserDeactivationScheduledBatch implements Database.Batchable<sObject>, System.Schedulable {
    private Integer batchSize = Integer.valueOf(Label.UserDeactivationBatchSize);
    private String licenseTypeFilter = 'Salesforce';
    private String myUserName = 'umeshjangid.1998@curious-badger-l22yc1.com';
    private String inactiveDays = Label.UserDeactivationInactiveThreshold;
    private Integer queryLimit = Integer.valueOf(Label.UserDeactivationQueryLimit);
    private static DateTime cutOffLastLoginDate;

    global Database.QueryLocator start(Database.BatchableContext c) {
        System.debug('Entering Start');

        if (!Test.isRunningTest()) {
            cutOffLastLoginDate = System.now().addDays(Integer.valueOf(inactiveDays));
        } else {
            cutOffLastLoginDate = System.now().addDays(60);
            queryLimit = 15;
        }

        return Database.getQueryLocator(
            'SELECT Id, Username, LastLoginDate, IsActive FROM User WHERE Username != :myUserName AND IsActive = true LIMIT :queryLimit'
        );
    }
    
    global void execute(Database.BatchableContext c, List<User> users) {
        System.debug('Entering Execute');
        
        String[] updateSuccess = new String[]{};
        Map<String, Exception> updateFail = new Map<String, Exception>();
        List<User> usersToDeactivate = new List<User>();

        // Collect user IDs to check for active flow interviews
        Set<Id> userIds = new Set<Id>();
        for (User user : users) {
            userIds.add(user.Id);
        }

        // Query for active flow interviews associated with the users
        Map<Id, Integer> userFlowCountMap = new Map<Id, Integer>();
        for (FlowInterview fi : [SELECT OwnerId FROM FlowInterview WHERE OwnerId IN :userIds AND InterviewStatus = 'Running']) {
            if (userFlowCountMap.containsKey(fi.OwnerId)) {
                userFlowCountMap.put(fi.OwnerId, userFlowCountMap.get(fi.OwnerId) + 1);
            } else {
                userFlowCountMap.put(fi.OwnerId, 1);
            }
        }

        for (User user : users) {
            if (!userFlowCountMap.containsKey(user.Id) || userFlowCountMap.get(user.Id) == 0) {
                user.isActive = false; // Make user deactivate
                usersToDeactivate.add(user);
            }
        }

        // Enqueue the Queueable job for user updates to avoid Mixed DML error
        if (!usersToDeactivate.isEmpty()) {
            System.enqueueJob(new UserDeactivationQueueable(usersToDeactivate));
        }
        
        System.debug('Attempting to send email');
        Messaging.reserveSingleEmailCapacity(2);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {Label.UserDeactivationAuditEmail};     
        mail.setToAddresses(toAddresses);
        mail.setReplyTo(Label.UserDeactivationAuditEmail);
        mail.setSenderDisplayName('Salesforce Support');
        mail.setSubject('Deactivated User List Audit');
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setPlainTextBody('Successful Updates ' + updateSuccess + ' Failed Updates: ' + updateFail);
        mail.setHtmlBody('<p>Successful Updates ' + updateSuccess + '</p> <p>Failed Updates: ' + updateFail + '</p>');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    global void finish(Database.BatchableContext c) {}
    
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new UserDeactivationScheduledBatch(), batchSize);
    }
}