trigger AccountTriggers on Account (before insert,before update,after insert, after update,before delete, after delete,after undelete) {
    /*//Assignment no 1:-Whenever an account is inserted,dont allow to add dublicate account
    if(Trigger.isInsert && Trigger.isBefore)
    {
        AccountTriggerHelper.duplicateAccountsCheck(Trigger.new);
    }*/
    //Assignment no 3:-Whenever an account is inserted, if there are existing account with the same name, 
    //then delete those account and reparent their contact records to the account you are inserting
    if(Trigger.isInsert )
    {   
        System.debug('insertafterupdate');
        AccountTriggerHelper.CreateTaskForAccount(Trigger.new);
        //AccountTriggerHelper.reparentContactWhenAccountInsertedwithSameName(Trigger.new);
    }
    //Assignment no 4:-Whenever an account is updated, remove all the contacts related to that existing account
    /*if(Trigger.isUpdate && Trigger.isBefore)
    {
        AccountTriggerHelper.removeContactWhenAccountUpdate(Trigger.new);
    }
    //Assignment no 8:-Write a trigger, so that when we create or update an account, account owner is added to ‘Sales Rep’ field
    if(Trigger.isInsert && Trigger.isbefore)
    {
        AccountTriggerHelper.accountOwnerAddedtoSalesRep(Trigger.new);
    }*/
}