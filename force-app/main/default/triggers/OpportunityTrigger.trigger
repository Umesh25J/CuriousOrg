trigger OpportunityTrigger on Opportunity (before insert,before update,after insert, after update,before delete, after delete,after undelete) 
{
    //Assignment no 2:-Write a trigger to add ‘_OrganizationName’ after every opportunity name on insertion
    //if(Trigger.isBefore && Trigger.isInsert)
    //{
        //OpportunityTriggerHelper.addOrgName(Trigger.new);
        //OpportunityTriggerHelper.updateMainCompietitors(Trigger.new);
    //}
    //Assignment no 7:-When an opportunity is created with probability = 50% then the opportunity owner will be automatically 
    //added to AccountTeam of the associated account for that opportunity
    if(Trigger.isAfter && Trigger.isInsert)
    {  
        //OpportunityTriggerHelper.addOppToAccTeamMember(Trigger.new);
		OpportunityTriggerHelper.createFurtherdetails(Trigger.new);
    } 
    /*if(Trigger.isAfter && Trigger.isUpdate)
    {
    }
    if(Trigger.isBefore && Trigger.isUpdate)
    {
    }
    if(Trigger.isAfter && Trigger.isDelete)
    {
    }
    if(Trigger.isBefore && Trigger.isDelete)
    {
    }
    if(Trigger.isAfter && Trigger.isUndelete)
    {
    }*/
    
        
    
}