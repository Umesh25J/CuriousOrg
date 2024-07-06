@isTest
public class DailyOppProcessorTest 
{
    
	@isTest
    private static void testScheduleApex()
    {
        List<Opportunity> oppList=new List<Opportunity>();
        String sch = '0 0 0 22 6 ? 2022';
        for(Integer i=0;i<500;i++)
        {
            if(i<250)
            {
                oppList.add(new Opportunity(Name='Test'+i,StageName='Prospecting',CloseDate=System.today()));  
            }else
            {
            	oppList.add(new Opportunity(Name='Test'+i,StageName='Prospecting',CloseDate=System.today(),LeadSource='Other'));    
            }
        }
        insert oppList;
        
        Test.startTest();
        String JobId=System.schedule('Process Opportunities', sch ,new DailyOppProcessor());
        Test.stopTest();
        
        List<Opportunity> updateOppList=[Select Id ,LeadSource From Opportunity Where LeadSource='Web'];
		System.assertEquals(200, updateOppList.size());    
    }
}