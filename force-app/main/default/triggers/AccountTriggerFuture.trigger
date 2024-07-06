trigger AccountTriggerFuture on Account (after insert) 
{
    List<Id> ids=new List<Id>();
    for(Account acc:Trigger.new)
    {
        //Future Implementation
        ids.add(acc.id);
        /*//Queueable Implementation
        QueueableTaskCreator qJob=new QueueableTaskCreator(acc.Id);
        Id jobId = system.enqueueJob(qJob);
        System.debug('Queueable '+qJob);*/
    }
    FutureTaskCreator.CreateTask(ids);
}