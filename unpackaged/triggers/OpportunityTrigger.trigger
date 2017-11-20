trigger OpportunityTrigger on Opportunity (after insert, after update) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            OpportunityTriggerHelper.createProject(OpportunityTriggerHelper.filterOpportunities(Trigger.oldMap, Trigger.new));
        }
    }

}