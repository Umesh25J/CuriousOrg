public class DailyLeadProcessor implements Schedulable
{
	public void execute(SchedulableContext ctx)
    {
         //System.debug('Context ' + ctx.getTriggerId()); // Returns the ID of the CronTrigger scheduled job
        List<Lead> leadList=[Select ID,LeadSource  From Lead Where LeadSource=null LIMIT 200];
        if(!leadList.isEmpty())
        {
        	for(Lead lists:leadList)
        	{
            	lists.LeadSource ='Dreamforce';
        	}
    	}
        if(!leadList.isEmpty())
        {
            update leadList;
        }
    }
}