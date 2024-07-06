trigger ClosedOpportunityTrigger on Opportunity (after insert , after update)
{
    /*List<Task> oppList = new List<Task>();
    for(Opportunity opp:Trigger.new)
    {
        if(opp.StageName!='Closed Won')
        {   
        }
        else
        {
            oppList.add(new Task(Subject='Follow Up Test Task',
                                   Status='Not Started',Priority='Normal',                               
                                   WhatId=opp.Id));
        }
    }
    if (oppList.size() > 0) {
        insert oppList;
    }*/
}