public with sharing class CaseTriggerHelper {
    public static void afterInsert (List<Case> newCaseList){
        for(Case rec : newCaseList){
            Integration_Zendesk.ZendeskTicketWrapper wrapper = new Integration_Zendesk.ZendeskTicketWrapper();
            wrapper.body = rec.Description;
            wrapper.priority = rec.Priority;
            wrapper.subject = rec.Subject;
            wrapper.name = 'Sanyukta';
            wrapper.email = 'test@gmail.com';
            calloutZendeskCreateTicket(JSON.serialize(wrapper));
        }
    }

    @future(callout = true)
    public static void calloutZendeskCreateTicket(String caseRecord){
        Integration_Zendesk.ZendeskTicketWrapper zendeskTicket = (Integration_Zendesk.ZendeskTicketWrapper) JSON.deserialize(caseRecord, Integration_Zendesk.ZendeskTicketWrapper.class);
        Integration_Zendesk.createTicket(zendeskTicket);
    }

}