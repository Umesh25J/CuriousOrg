@isTest
private class DailyLeadProcessorTest {
    
    private static String CRON_EXP = '0 0 0 ? * * *';

    @isTest
    private static void testSchedulableClass() {
        
        List<Lead> leads = new List<Lead>();
        for (Integer i=0; i<500; i++) 
        {
            if ( i < 250 ) 
            {
                leads.add(new Lead(LastName='Rakesh', Company='Salesforce'));
            } else 
            {
                leads.add(new Lead(LastName='Rakesh', Company='Salesforce', LeadSource='Other'));
            }
        }
        insert leads;

        Test.startTest();
        String jobId = System.schedule('Process Leads', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'ERROR: At least 1 record not updated correctly');
		
    }
}
/*@isTest
public class DailyLeadProcessorTest 
{
    private static String CRON_EXP = '0 0 0 ? * * *';
	@isTest
    private static void testScheduleJob()
    {
        List<Lead> newLead=new List<Lead>();
        for(Integer i=0;i<200;i++)
        {
            Lead newLeads=new Lead();
            newLeads.LastName='Create Test'+i;
            newLeads.Company='XYZ';
            newLeads.leadSource='';
            newLead.add(newLeads);
        }
        insert newLead;
        
        Test.startTest();
        String jobId=System.schedule('New Lead ', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        List<Lead> newLeadss=[Select Id,LeadSource From Lead Where LeadSource='Dreamforce'];
        System.assertEquals(200, newLeadss.size(),'ERROR:AT LEAST RECORDS HAVE LEADSOURCE');
        
    }
}
*/