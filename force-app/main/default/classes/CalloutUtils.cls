public class CalloutUtils {
    public static HttpRequest prepareRequest(String method, String endpoint, String body, String Accept, String contentType) {
        HttpRequest request = new HttpRequest();
        request.setMethod(method);
        request.setEndpoint(endpoint);
        if(!String.isBlank(body)) request.setBody( body);
        if(!String.isBlank(Accept)) request.setHeader('Accept', Accept);
        if(!String.isBlank(contentType)) request.setHeader('Content-Type', contentType);
        return request;
    }
}