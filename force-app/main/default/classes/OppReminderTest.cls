@isTest
public class OppReminderTest 
{
    public static String CRON_EXP='0 0 0 22 6 ? 2022';
	@isTest
    private static void testScheduleJob()
    {
        List<Opportunity> oppList=new List<Opportunity>();
        for(Integer i=0;i<5;i++)
        {
            Opportunity opp =new Opportunity();
            opp.Name='OppTest'+i;
            opp.StageName='Prospecting';
            opp.CloseDate=Date.Today().addDays(-7);
            oppList.add(opp);
        }
        
        insert oppList;
        Set<Id> oppIds=new Set<Id>();
        for(Opportunity opp:oppList)
        {
        	oppIds.add(opp.Id);    
        }
        
        Test.startTest();
        String JobId=System.schedule('Create Task', CRON_EXP ,new OppReminder());
        Test.stopTest();
        
        List<Task> taskList=[Select Id  From Task Where WhatId IN : oppIds];
		System.assertEquals(5, taskList.size());    
    }
}