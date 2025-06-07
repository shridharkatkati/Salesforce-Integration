public with sharing class CustomLookupController {
    @AuraEnabled(cacheable = true)
    public static List<SObject> searchRecords(String objectAPIName, String searchStr){
        String searchKey = '%'+searchStr+'%';
        String queryString = 'SELECT Id, Name, BillingState, BillingCity FROM ' + objectAPIName + ' WHERE Name LIKE :searchKey';
        List<SObject> recordsList = Database.query(queryString, AccessLevel.USER_MODE);
        return recordsList;
    }
}