trigger EmailMessageTrigger on EmailMessage (before insert,after insert) {
    // Trigger handler for Case
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            EmailMessageTriggerHandler.beforeInsert(Trigger.new);
        } else if (Trigger.isUpdate) {

        }
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            EmailMessageTriggerHandler.afterInsert(Trigger.new);
        } else if (Trigger.isUpdate) {

        }
    }
}