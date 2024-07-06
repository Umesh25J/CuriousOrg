@isTest
public class caseTriggerHelperTest 
{
	@isTest
    static void changeCaseOwner()
    {
        Case caseRecord=new Case();
        caseRecord.Status='Working';
        caserecord.Origin='Phone';
        
        insert caseRecord;
        
        Case checkCases=[SELECT OwnerId,CreatedByID FROM Case WHERE id=:caseRecord.Id];
        checkCases.OwnerId=checkCases.CreatedById;
        update checkCases;
        
        List<Case> CaseRecords=[SELECT status,ownerId,CreatedByID FROM Case WHERE id=:caseRecord.Id];
        
        Case checkCase=[SELECT OwnerId FROM Case WHERE id=:caseRecord.Id];
        System.assertEquals('0055j000004I9fDAAS',checkcase.OwnerId);
    }
}