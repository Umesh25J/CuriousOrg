public class OppReminder implements Schedulable
{
	public void execute(SchedulableContext ctx)
    {
        List<Opportunity> oppList=[SELECT Id, StageName,CloseDate,OwnerId From Opportunity Where IsClosed = False AND CloseDate <TodaY];
		List<Task> taskList=new List<Task>();
        if(!oppList.isEmpty())
        {
            for(Opportunity opp: oppList)
            {
                Task tsk=new Task();
                tsk.Subject='Reminder Task';
                tsk.Status='Open';
                tsk.Priority='Noraml';
                tsk.WhatId=opp.Id;
                tsk.OwnerId=opp.OwnerId;
                taskList.add(tsk);
            }
        }
        if(!taskList.isEmpty())
        {
            insert taskList;
        }
    }
}