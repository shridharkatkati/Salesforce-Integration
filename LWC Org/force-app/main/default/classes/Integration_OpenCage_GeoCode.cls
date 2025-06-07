public with sharing class Integration_OpenCage_GeoCode {
    public static void getAddressFromCoordinates(String accountId){
        // get the account lattitude and longitude
        Account acc = [Select Location__Latitude__s,Location__Longitude__s, Description from Account where Id =: accountId];

        HttpRequest httpReq = new HttpRequest();
        httpReq.setMethod('GET');
        String endpointURI = System.Label.Open_Cage_GeoCode_URL+'?key='+System.Label.Open_Cage_GeoCode_API_KEY+'&q='+acc.Location__Latitude__s+','+acc.Location__Longitude__s;
        httpReq.setEndpoint(endpointURI);

        try {
            HttpResponse httpResp = new Http().send(httpReq);
             // step: 4 process the resopnse
             // step 5: copy the entire JSON data returned from status OK response and remove the unwanted properties from the JSON response using https://codebeautify.org/jsonviewer tool 

            //  step 6: next using the adminbooster json to apex tool https://www.adminbooster.com/tool/json2apex generate the wrapper class to store the JSON data
             if(httpResp.getStatusCode() == 200){ // status = ok
                Open_Cage_GeoCode_Wrapper wrapper = (Open_Cage_GeoCode_Wrapper) System.JSON.deserialize(httpResp.getBody(), Open_Cage_GeoCode_Wrapper.class);
                
                if(wrapper?.results?.size() > 0){ // equivalent to if (wrapper != null && wrapper.results != null && wrapper.results.size() > 0)
                    Open_Cage_GeoCode_Wrapper.results result = wrapper?.results?.get(0);
                    acc.Description = result?.formatted;
                    update acc;
                }
             }
        } catch (Exception exp) {
            system.debug(exp.getMessage());
        }
    }
}