public with sharing class Integration_RandomJokes {
    public static void getRandomJokes(){
        
        //Step1: form the request body
        HttpRequest httpReq = new HttpRequest();
        httpReq.setMethod('GET');
        String endpointURI = 'https://official-joke-api.appspot.com/random_joke';
        // Step1.2: set the endpoint to the http request 
        httpReq.setEndpoint(endpointURI);

        // Step2: create a http instance to send the request and receive response
        Http http = new Http();

       try {
             // Step 3: send the request and receive the response
            HttpResponse httpResp = http.send(httpReq);

            // step: 4 process the resopnse
            System.debug('respnse Status: ' + httpResp.getStatus());
            System.debug('respnse Status code: ' + httpResp.getStatusCode());
            System.debug('respnse body: ' + httpResp.getBody());
       } catch (Exception exp) {
        // 
        System.debug(exp.getMessage());
        System.debug(exp.getTypeName());
       }
    }
}