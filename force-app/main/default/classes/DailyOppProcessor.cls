public class DailyOppProcessor implements Schedulable
{
    public void execute(SchedulableContext ctx)
    {
        List<Opportunity> oppList=[Select Id,LeadSource 
                                   From Opportunity 
                                   Where LeadSource=null
                                   Limit 200];
        for(Opportunity opp : oppList)
        {
            opp.LeadSource = 'Web';
        }
        if(!oppList.isEmpty())
        {
            update oppList;
        }
    }
}