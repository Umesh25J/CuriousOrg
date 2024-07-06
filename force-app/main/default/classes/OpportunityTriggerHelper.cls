public class OpportunityTriggerHelper 
{
	//Write a test class to test the following apex code
    public static void createFurtherdetails(List<Opportunity> oppRecords)
    {
    	Set<Id> accSpecificlds=new Set<Id>();
        List<OpportunityContactRole> ocrList=new List<OpportunityContactRole>();
    	Map<Id,List<Contact>> accountSpecificContacts=new Map<id,List<Contact>>();
        for(Opportunity o:oppRecords)
        {
            if(o.AccountSpecificOppId__c!=Null)
           {
               accSpecificlds.add(o.AccountSpecificOppId__c);
           }
        }
        System.debug(accSpecificlds);
        for(Contact con:[SELECT Id,AccountSpecificId__c FROM Contact WHERE AccountSpecificId__c in:accSpecificlds])
        {
            if(!accountSpecificContacts.containsKey(con.AccountSpecificId__c))
           		accountSpecificContacts.put(con.AccountSpecificId__c,new List<Contact>());
            accountSpecificContacts.get(con.AccountSpecificId__c).add(con);
        }
        System.debug(accountSpecificContacts);
        for(Opportunity opp:oppRecords)
        {
            if(accountSpecificContacts.containsKey(opp.AccountSpecificOppId__c) && accountSpecificContacts.get(opp.AccountSpecificOppId__c)!=NULL)
            {
                Boolean isFirstContact=true;
                for(Contact c:accountSpecificContacts.get(opp.AccountSpecificOppId__c))
                {
                    OpportunityContactRole ocr = new OpportunityContactRole(ContactId=c.Id,OpportunityId=opp.id);
                    if(isFirstContact)
                    {
                        ocr.IsPrimary=true;
                        isFirstContact=false;
                    }
                    ocrList.add(ocr);
                }
            }   
        } 
        if(ocrList.size()>0)
            insert ocrList;
    }
    /*public static void addOrgName(List<Opportunity> oppRecords)
    {
        Organization myOrg = [Select Name From Organization];
        for(Opportunity op:oppRecords)
        {
            op.Name=op.Name+'_'+myOrg.Name;
        } 
    }
    public static void addOppToAccTeamMember(List<Opportunity> oppRecords)
    {
        List<AccountTeamMember> newACTlist=new List<AccountTeamMember>();
        for(Opportunity opp:oppRecords)
        {
            AccountTeamMember act=new AccountTeamMember();
            act.AccountId=opp.AccountId;
            act.UserId=opp.OwnerId;
            act.TeamMemberRole='Account Manager';
            act.OpportunityAccessLevel='Read';
            act.AccountAccessLevel='Read';
            act.ContactAccessLevel='Read';
            act.CaseAccessLevel='Read';
            newACTlist.add(act);
        }
       insert newACTlist;
    }
    public static void updateMainCompietitors(List<Opportunity> oppRecords)
    {
    	for(Opportunity newOpp:oppRecords)
        {
           if(newOpp.MainCompetitors__c==null)
           {
               newOpp.MainCompetitors__c='Competitor01';
           }
        }
    }*/
    /*
public class OpportunityTriggerHelper 
{
    //(3.1)Method which get executed after insert/update trigger gets hit.
    public static void updateAccountFields(List<Opportunity> OppRecords)
    {
        //List of Id's for storing id's of Accounts Related to Opportunity Records which we get through trigger.new.
        List<ID> AssociatedAccountIds=new List<Id>();
        //Set of Account which needs to be updated.
        Set<Account> accountRecordsToUpdate=new Set<Account>();
        //List of Opportunities with same AccountId as in trigger.new
        List<Opportunity> OppRecordsWithAccount=new List<Opportunity>();
        //List of Accounts Associated with these opportunities.
        List<Account> AssociatedAccountRecords=new List<Account>();
        //Iterates through each Opportunity in OppRecordsWithAccount.
        for(Opportunity opp:OppRecords)
        {
            //AccountId of each opp added to list of ids
            AssociatedAccountIds.add(opp.AccountId);
        }
        //Query for retrieving Opportunity Records By Account Id List.
        OppRecordsWithAccount=[SELECT id,AccountID,CloseDate,Amount FROM Opportunity WHERE AccountId IN : AssociatedAccountIds];
        System.debug(OppRecordsWithAccount);
        //Query for retrieving Account Records for all Opportunity Records in OppRecordsWithAccount.
        AssociatedAccountRecords=[SELECT id,Sum_of_Open_Opportunities_amount__c,Highest_Open_Opportunities_amount__c,(SELECT id,AccountID,CloseDate,Amount FROM Opportunities) FROM Account WHERE id IN : AssociatedAccountIds];
        System.debug(AssociatedAccountRecords);
        //Iterates Account for each Opportunity and Updates the fields on Account.
        for(Opportunity opp:OppRecordsWithAccount)
        {
            for(Account acc:AssociatedAccountRecords)
            {
                if(opp.AccountId==acc.id)
                {
                    if(opp.CloseDate>System.today())
                        acc.Sum_of_Open_Opportunities_amount__c+=opp.amount;
                    if(opp.amount>acc.Highest_Open_Opportunities_amount__c)
                    {
                        acc.Highest_Open_Opportunities_amount__c=opp.amount;
                    }
                    //add each account to list of accounts to be updated.
                    accountRecordsToUpdate.add(acc);
                }
            }
        }
        //As DML cannot be done on Set,so assigning Account Records to Update to a list of Account
        List<Account> acclist=new List<Account>();
        //Iterates each account to update and add to list of account
        for(Account a:accountRecordsToUpdate)
        {
            acclist.add(a);
        }
        //DML on accounts to update.
        Upsert acclist;
    }
    //(3.2)Method which get executed before insert/update trigger gets hit.
    public static void updateMainCompetitors(List<Opportunity> oppRecords)
    {
        //Iterates each opportunity record to Update.
        for(Opportunity Opp:oppRecords)
        {
            //Check if MainCompetitors__c is empty
            if(Opp.MainCompetitors__c==null)
            {
                //Populates MainCompetitors__c field.
                Opp.MainCompetitors__c='Competitor01';
            }
        }
    } 
}*/
}