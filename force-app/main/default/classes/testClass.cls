trigger OLITrigger on OpportunityLineItem (after insert) {
    testClass.afterEvents(Trigger.newMap);
}

public with sharing class testClass {
    public static void afterEvents(Map<Id,OpportunityLineItem> newMap) {
        set<id> oppIds = new Set<id>();
        for(OpportunityLineItem oli : newMap.values()) {
            oppIds.add(oli.OpportunityId);
        }
        // get the count of oli for each opp where itemPrice > 50000 group by accId
        List<Opportunity> oppList = [Select Id, AccountId, (Select Id from OpportunityLineItems where ListPrice > 50000) from Opportunity where id in :oppIds ]; 
        List<Account> updatelist = new List<Account>();
        Account acc;
        Map<Id,Integer> accIdVsOliCntMap = new Map<Id,Integer>();
        for(Opportunity o : oppList){
            if(!accIdVsOliCntMap.containsKey(o.AccountId)) {
                accIdVsOliCntMap.put(o.AccountId,o.OpportunityLineItems.size());
            } else {
                accIdVsOliCntMap.put(o.AccountId,accIdVsOliCntMap.get(o.AccountId) + o.OpportunityLineItems.size());
            }
        }
        for(Id accId : accIdVsOliCntMap.keySet()) {
            acc = new Account(Id = accId, oliCount__c = accIdVsOliCntMap.get(accid));
            updatelist.add(acc);
        }
        
        if(!updatelist.isEmpty()) update updatelist;
    }
}