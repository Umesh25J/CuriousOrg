public class CaseHandler 
{
     // Method to handle Before Insert event
    public static void beforeInsert(List<Case> newCases) {
        // Add your logic for Before Insert here
        Id thisUserId = UserInfo.getUserId();
        User thisUser = [Select id From User u Where id=:thisUserId AND IsActive = true AND u.Profile.Name = 'System Administrator' 
                    And u.Profile.PermissionsModifyAllData=true limit 1];
        for (Case c : newCases) {
            System.debug('RecordName-'+c.RecordType.Name );
            if (c.recordTypeId == '0125j000001PGAEAA4' && thisUser != null) {
                // Check if the user is not a system admin
                    //c.addError('You do not have permission to manually create cases of the "Appliance Save the Sale" record type.');
            }
        }
    }

    // Method to handle After Insert event
    public static void afterInsert(List<Case> newCases) {
        // Add your logic for After Insert here
    }

    // Method to handle Before Update event
    public static void beforeUpdate(Map<Id, Case> oldMap, List<Case> updatedCases) {
        // Add your logic for Before Update here
    }

    // Method to handle After Update event
    public static void afterUpdate(Map<Id, Case> oldMap, List<Case> updatedCases) {
        System.debug('Enterned in this method');
        List<Id> caseId= new List<Id>();
        for(Case newRec : updatedCases){
            Case oldcase = oldMap.get(newRec.Id);
            if(oldCase.Status == 'New' && newRec.Status == 'Closed - Refund Processed (Closed)'){
                System.debug('Enterned in this ');
                caseId.add(newRec.Id);
            }
        }
        if(!caseId.isEmpty())
        caseEmailMessageEmailService.toSendEmailWithTemplate(caseId[0]);
    }
	/*public static void changeOwner(List<Case> oppRecords)
    {
        List<Case> oldCase=new List<Case>();
    	List<Case> casesToUpdate=new List<Case>();
    	String value1='priced-(Initial)';
    	String value2='priced-(Re-priced)';
    	String value3='priced-(File loaded)';
    	oldCase=[SELECT Id,OwnerID,CreatedById FROM Case WHERE (Status=:value1 OR Status=:value2 OR Status=:value3) AND ID IN : Trigger.new ];
    	for(Case cases:oppRecords)
    	{
        	cases.ownerID=cases.createdByID;
        	casesToUpdate.add(cases);
    	}
    	update casesToUpdate;   
    }*/
}