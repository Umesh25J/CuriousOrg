global class RemindOppOwners implements Schedulable
{
	global void execute(SchedulableContext ctx)
    {
        List<Opportunity> oppList=[Select Id,Name,
                                   OwnerId,CloseDate 
                                   From Opportunity 
                                   Where IsClosed = False And 
                                   CloseDate < Today];
        Taskutils.remindOwners(oppList);
    }
}