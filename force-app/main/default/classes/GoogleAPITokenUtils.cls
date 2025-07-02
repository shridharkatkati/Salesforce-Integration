public with sharing class GoogleAPITokenUtils {
    // public GoogleAPITokenUtils() {

    // }
    public static PageReference getAuthCode(){
        Salesforce_Config__mdt config = Salesforce_Config__mdt.getInstance('GoogleCredentials');
       if (config != null){
        String authURL = config.authurl__c +'?client_id='+config.clientId__c+'&redirect_uri='+config.redirect_URL__c+'&response_type=code&scope=openid profile';
        return new PageReference(authURL);
       }else{
        System.debug('no config found');
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, ' Config not found!'));
       }
       return null;
    }

    public static void getAccessToken(){// from the above auth code get the access token 
        // retrieve the auth code from the page reference 
        Salesforce_config__mdt config = Salesforce_config__mdt.getInstance('GoogleCredentials');
        if(config != null){
            String authCode = ApexPages.currentPage().getParameters().get('code');
            String requestBody = 'client_id='+EncodingUtil.urlEncode(config.clientId__c, 'UTF-8')+'&client_secret='+EncodingUtil.urlEncode(config.clientsecret__c, 'UTF-8')+'&code='+EncodingUtil.urlEncode(authCode, 'UTF-8')+'&grant_type=authorization_code&redirect_uri='+EncodingUtil.urlEncode(config.redirect_URL__c, 'UTF-8');
            HttpRequest request = CalloutUtils.prepareRequest('POST',config.Access_token_url__c,requestBody,'application/json','application/x-www-form-urlencoded');
            try {
                HttpResponse response = new Http().send(request);
                if(response.getStatusCode() == 200){
                    GoogleAccessTokenWrapper wrapper = (GoogleAccessTokenWrapper) JSON.deserialize(response.getBody(), GoogleAccessTokenWrapper.class);
                    Map<String,Object> fieldVsValuesMap = new Map<String,Object>();
                    fieldVsValuesMap.put('accesstoken__c',wrapper.access_token);
                    fieldVsValuesMap.put('expires_in__c',wrapper.expires_in);
                    fieldVsValuesMap.put('scope__c',wrapper.scope);
                    MetadataDeploymentUtils deployment = new MetadataDeploymentUtils();
                    deployment.createUpdateAndDeployMetadata('Salesforce_Config__mdt','GoogleCredentials','GoogleCredentials',fieldVsValuesMap);
                }
            } catch (Exception ex) {
                System.debug(ex.getMessage());
            }

        } else {
            System.debug('no config found');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Config not found!'));
        }
    }
}