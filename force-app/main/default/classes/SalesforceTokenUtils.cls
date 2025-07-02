public with sharing class SalesforceTokenUtils {
    public PageReference getAccessToken(){
        Salesforce_Config__mdt config = Salesforce_Config__mdt.getInstance('Salesforce_Config');
        system.debug(config);
        if(config != null){
            // https://login.salesforce.com/services/oauth2/authorize?client_id=3MVG9GCMQoQ6rpzQdLe.R_t8x3J0VfnwD9Ye24VpKjAtb2PJiZlox4y1brdmS8NgGzYC1vnTEd4vvdwNrc6gM&redirect_uri=https://www.google.com/&response_type=code
            String authorizationURL = config.Environment__c == 'Production' ? 'https://login.salesforce.com' : 'https://test.salesforce.com';
            authorizationURL += config.authurl__c+'?client_id='+config.clientid__c+'&redirect_uri=';
            String redirectURL = System.URL.getOrgDomainUrl().toExternalForm()+'/apex/'+config.PageName__c;
            authorizationURL += redirectURL+'&response_type=code'; 
            return new PageReference(authorizationURL);
        }
        else{
            return null;
        }
    }
    public void getAuthCode(){// once we have the auth code we make a post call to get the access token
        Salesforce_Config__mdt config = Salesforce_Config__mdt.getInstance('Salesforce_Config');
        if(config != null){
            String authCode = ApexPages.currentPage().getParameters().get('code');
            System.debug(authCode);
            
            // create endpoint /
            String endpointURL = '';
            String baseURL = config.Environment__c == 'Production' ? 'https://login.salesforce.com' : 'https://test.salesforce.com';
            endpointURL += baseURL+'/services/oauth2/token';
            String postRequestBody = 'grant_type=authorization_code&code='+authcode+'&client_id='+config.clientid__c+'&client_secret='+config.clientsecret__c+'&redirect_uri='+System.Label.OAuth2_0SF_Redirect_URL; 

            try {
                HTTPRequest request = new HTTPRequest();
                request.setMethod('POST');
                request.setEndpoint(endpointURL);
                request.setHeader('Content-type', 'application/x-www-form-urlencoded');
                request.setHeader('Accept', 'application/json');
                request.setBody(postRequestBody);

                // Send HTTP request
                HTTPResponse response = new HTTP().send(request);
                if(response.getStatusCode() != null){
                    System.debug(response.getBody());
                }
            } catch (Exception e) {
                system.debug(e.getMessage());
            }

            
        }
    }
}