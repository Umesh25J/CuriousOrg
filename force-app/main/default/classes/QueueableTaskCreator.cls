public class QueueableTaskCreator implements Queueable
{
	private String recId;
    public QueueableTaskCreator(String recId)
    {
        this.recId=recId;
    }
    public void execute(QueueableContext context)
    {
        Task tsk=new Task();
        tsk.WhatId=recId;
        tsk.Subject='Created From Queueable';
        insert tsk;
    }
}