@isTest
public class OpportunityTriggerHelperTest 
{
    @isTest
    static void createFurtherdetailsTest()
    {
        Account accRecord=new Account();
        accRecord.Name='Testing';
        
        insert accRecord;
 
        Contact newCon=new Contact();
        newCon.LastName='TestingCon';
        newCon.AccountId=accRecord.Id;
        insert newCon;
        
        Opportunity opp=new Opportunity();
        opp.Name='MyOpportunity';
        opp.StageName='Prospecting';
        opp.CloseDate=date.parse('6/10/2022');
        opp.AccountId=accRecord.Id;
        
        insert opp;
        
        Opportunity opportunities=[SELECT name FROM Opportunity WHERE id=:opp.Id];
        System.assertEquals('MyOpportunity',opportunities.Name);
        List<OpportunityContactRole> newRole=[SELECT Id, OpportunityId, ContactId FROM OpportunityContactRole WHERE OpportunityId=:opp.Id AND ContactId=:newCon.Id];
        System.assertEquals(newRole.size(),1);
    }
	/*@isTest
    static void addOrgNametoOpportunity()
    {
        Account accRecord=new Account();
        accRecord.Name='Testing';
        
        insert accRecord;
 
        Opportunity opp=new Opportunity();
        opp.Name='MyOpportunity';
        opp.StageName='Prospecting';
        opp.CloseDate=date.parse('6/10/2022');
        opp.AccountId=accRecord.Id;
        
        insert opp;
        
        Opportunity opportunities=[SELECT name FROM Opportunity WHERE id=:opp.Id];
        System.assertEquals('MyOpportunity_Alien Brainz',opportunities.Name);
    }
    @isTest
    static void AddAccountTeamMember()
    {
        Account accRecord=new Account();
        accRecord.Name='Testing';
        
        insert accRecord;
 
        Opportunity opp=new Opportunity();
        opp.Name='MyOpportunity';
        opp.StageName='Prospecting';
        opp.CloseDate=date.parse('6/10/2022');
        opp.Probability=50;
        opp.AccountId=accRecord.Id;
        
        insert opp;
        
        AccountTeamMember AccTeamMember =[SELECT AccountId FROM AccountTeamMember WHERE AccountId=:opp.AccountId];
        
        System.assertEquals(accRecord.Id, AccTeamMember.AccountId);
    }
    @isTest
    static void updateSumOfOpportunityAmount()
    {
        Account accRecord=new Account();
        accRecord.Name='Testing';
        
        insert accRecord;
 
        Opportunity opp=new Opportunity();
        opp.Name='MyOpportunity';
        opp.StageName='Prospecting';
        opp.CloseDate=date.parse('6/10/2022');
        opp.Probability=50;
        opp.AccountId=accRecord.Id;
        
        insert opp;
        
        
        //List<Account> results=[SELECT The_highest_open_opportunity_s_amount__c, Sum_of_the_open_opportunities_amount__c FROM Account Where AccountId=:opp.AccountID];
        AccountTeamMember AccTeamMember =[SELECT AccountId FROM AccountTeamMember WHERE AccountId=:opp.AccountId];
        
        System.assertEquals(accRecord.Id, AccTeamMember.AccountId);
    }
    @isTest
    static void updateMainCompetitors()
    {
        Opportunity opp=new Opportunity();
        opp.Name='MyOpportunity';
        opp.StageName='Prospecting';
        opp.CloseDate=date.parse('6/10/2022');
        opp.Probability=50;
        
        Test.startTest();
        DataBase.SaveResult savelist=DataBase.insert(opp,false);
        Test.stopTest();
        
        Opportunity op1=[Select MainCompetitors__c From Opportunity WHERE Id=:opp.Id];
        System.assertEquals('Competitor01', op1.MainCompetitors__c);

    }*/
}