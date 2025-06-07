public with sharing class AccountController {
    
    @AuraEnabled (cacheable=true)
    public static List<Account> getAccounts(){
       return [SELECT id, Name, Industry, Website, Phone, BillingCity, BillingState, BillingStreet, BillingCountry, NumberOfEmployees, AnnualRevenue,Rating
       FROM Account with USER_MODE ];
    }

}