trigger CaseHandlerTrigger on Case (after insert, after update, before insert, before update) 
{
    // Trigger handler for Case
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            CaseHandler.beforeInsert(Trigger.new);
        } else if (Trigger.isUpdate) {
            CaseHandler.beforeUpdate(Trigger.oldMap, Trigger.new);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            CaseHandler.afterInsert(Trigger.new);
        } else if (Trigger.isUpdate) {
            CaseHandler.afterUpdate(Trigger.oldMap, Trigger.new);
        }
    }
    //Assignment 5:-Write a trigger to update the owner of a case, based on the values selected within a picklist field status. 
    //If the values corresponds to any of {priced-(Initial) , priced-(Re-priced) , priced-(File loaded)}, 
    //then populate the owner field with created by field data

    /*if(Trigger.isAfter && Trigger.isInsert)
    {
        caseTriggerHelper.changeOwner(Trigger.new);
    }*/
    
}