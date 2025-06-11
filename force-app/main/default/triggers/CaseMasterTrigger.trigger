trigger CaseMasterTrigger on Case (before insert, after insert) {
  switch on Trigger.operationType {
    when AFTER_INSERT {
      CaseTriggerHelper.afterInsert(Trigger.new);
    }
    when BEFORE_INSERT { 
      
    }
  }

}