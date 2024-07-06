public class FutureTaskCreator 
{
	@future(callout=true)
    public static void CreateTask(List<Id> recID)
    {
        List<Task> newTask=new List<Task>();
        for(Id ids:recID)
        {
        	Task tak =new Task();
        	tak.Subject='Creating from Future';
        	tak.WhatId=ids; 
            newTask.add(tak);
        }
        insert newTask;
    }
}