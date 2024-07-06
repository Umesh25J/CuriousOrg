public with sharing class AccountTriggerHandler 
{
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    public static boolean IsFromBachJob ;
    public static boolean isFromUploadAPI=false;
    
    public AccountTriggerHandler(boolean isExecuting, integer size)
    {
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
            

    public void OnBeforeInsert(List<Account> newAccount)
    {
        system.debug('Account Trigger On Before Insert');
    }
    public void OnAfterInsert(List<Account> newAccount)
    {
        system.debug('Account Trigger On After Insert');
    }
    public void OnAfterUpdate( List<Account> newAccount, List<Account> oldAccount, Map<ID, Account> newAccountMap , Map<ID, Account> oldAccountMap )
    {
        system.debug('Account Trigger On After Update ');
        //AccountActions.updateContact (newAccount);
    }
    public void OnBeforeUpdate( List<Account> newAccount, List<Account> oldAccount, Map<ID, Account> newAccountMap , Map<ID, Account> oldAccountMap )
    {
        system.debug('Account Trigger On Before Update ');
    }

    @future 
    public static void OnAfterUpdateAsync(Set<ID> newAccountIDs)
    {

    }      
    public boolean IsTriggerContext
    {
        get{ return m_isExecuting;}
    }
    
    public boolean IsVisualforcePageContext
    {
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsWebServiceContext
    {
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsExecuteAnonymousContext
    {
        get{ return !IsTriggerContext;}
    }
}