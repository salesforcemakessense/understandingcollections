trigger OpportunityTrigger on Opportunity (before update) {

    if(Trigger.isBefore && Trigger.isUpdate){
        MapsUtil.handleBeforeUpdate(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
    }

}