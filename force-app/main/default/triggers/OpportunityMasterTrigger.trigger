trigger OpportunityMasterTrigger on Opportunity (before insert, after insert, before update, after update) {
  switch on Trigger.operationType {
    when AFTER_INSERT {
      OpportunityTriggerHelper.afterEvents(Trigger.new, Trigger.oldMap);
    }
  }
}