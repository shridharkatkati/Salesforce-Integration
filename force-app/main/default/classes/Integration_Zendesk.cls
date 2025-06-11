// BRANCH: BasicAuthentication_Zendesk_Integration
public with sharing class Integration_Zendesk {
    // Wrapper class to store the ticket details
    public class ZendeskTicketWrapper{
        public String body;
        public String priority;
        public String subject;
        public String name;
        public String email;
    }

    /* Setup for wrapper class ZendeskTicketWrapper 

    Integration_Zendesk.ZendeskTicketWrapper wrapper = new Integration_Zendesk.ZendeskTicketWrapper();
    wrapper.body = 'The generator I bought is malfunctioning. Can I get a replacement?';
    wrapper.priority = 'High';
    wrapper.subject = 'CTL: Close the Loop: generator issue';
    wrapper.name = 'Sanyukta';
    wrapper.email = 'test@gmail.com';
    */ 

    public static void createTicket(Integration_Zendesk.ZendeskTicketWrapper zendeskRecord){
        // initialize the request parameters
        String requestBody=	'{'+
		'    "ticket": {'+
		'        "comment": {'+
		'            "body": "'+zendeskRecord.body+'"'+
		'        },'+
		'        "priority": "'+zendeskRecord.priority+'",'+
		'        "subject": "'+zendeskRecord.subject+'",'+
		'        "requester": {"name": "'+zendeskRecord.name+'", "email": "'+zendeskRecord.email+'" }'+
		'    }'+
		'}';

        String endpoint = System.label.Zendesk_Endpoint+'/api/v2/tickets';
        System.debug(endpoint);
        try {
            // Step 1: create an HttpRequest)
            HttpRequest request = new HttpRequest();
            request.setMethod('POST');
            request.setEndpoint(endpoint);

            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Accept', 'application/json');
            request.setHeader('Authorization','Basic ' + EncodingUtil.base64Encode(Blob.valueOf(System.Label.Zendesk_username + ':' + System.Label.Zendesk_APIKey)));
            
            request.setBody(requestBody);
            // Step 2: Send the Post request to the Zendesk endpoint
            HttpResponse response = new Http().send(request);

            // Step 3: Verify the response
            if(response.getStatusCode() == 201){
                System.debug(response.getBody());
                System.debug('Ticket Successfully Created on Zendesk');
            }
        } catch (Exception exp) {
            System.debug('Error: \n'+ exp.getMessage());
        }
    }
}