/**
 * @description This class provides an exmaple of 
 * making REST callouts to external endpoints. It utilizes NamedCredentials
 * for security. 
 */
public class RestClient {
 
   @testVisible
    private static Map<String, String> defaultHeaders = new Map<String, String>{
        'Content-Type' => 'application/json','Accept' => 'application/json'
    };
    
    /**
     * @description The name of the Named Credential to use
     */
  
    public static String namedCredentialName { get; set; }

     private static HttpResponse makeApiCall(
        string method,
        String path,
        String body,
        Map<String, String> headers,
        Boolean isMDMReq,
        string querySoql
    ) {
        HttpResponse toReturn;
       if(!isMDMReq){
      
        HttpRequest apiRequest = new HttpRequest();
        
        Map<String, String> functionalHeaders = (headers != null)
            ? headers
            : RestClient.defaultHeaders;
        for (String header : functionalHeaders.keySet()) {
            apiRequest.setHeader(header, functionalHeaders.get(header));
        }
        if (
            String.isNotBlank(body) &&
            (method == 'POST')
        ) {
            apiRequest.setBody(body);
        }
        if(RestClient.namedCredentialName !=null){
        apiRequest.setEndpoint(
            'callout:' +
            RestClient.namedCredentialName +
            path
        );
        }
        else{
         apiRequest.setEndpoint(
            path
        );
        }
        apiRequest.setMethod(method);
        Http http = new Http();
        toReturn = http.send(apiRequest);
        }
        else{
        toReturn=masterDataFetch(querySoql);
        }
        return toReturn;
    }

    
    /**
     * @description convenience method for a GET Call that only requires a path
     * @return     `HTTPResponse`
     */
    public static HttpResponse get(String path,string body,Map<String,String> headers,Boolean isMDMReq,string querySoql) {
        return makeApiCall('GET', path,body,headers,isMDMReq,querySoql);
    }

    public static HttpResponse post(String path, String body,Map<String,String> headers,Boolean isMDMReq,string querySoql) {
        return makeApiCall('POST', path, body,headers,isMDMReq,querySoql);
    }

  
    @testVisible
     private static HttpResponse masterDataFetch(String query) {
      HttpResponse res = new HttpResponse();
      try
      {
      
        String safeQueryString = String.escapeSingleQuotes(query);
        List<Sobject> fetchedRes=Database.query(safeQueryString);
        res.setStatuscode(200);
        res.setBody(JSON.serialize(fetchedRes));
        }
        Catch(Exception ex){
        res.setStatuscode(400);
        res.setBody('Query Exception');
        }
        return res;
    }
}