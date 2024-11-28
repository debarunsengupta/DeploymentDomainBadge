public class ApiServiceClass extends RestClient {
    @testVisible
    private static final String NAMEDCREDENTIAL = 'Google';
    private static final String ENDPOINT = 'https://api.google.com';
   
     
    /**
     * @description Internal custom exception used by this class for errors
     */
    public class ApiException extends Exception {
    }

    /**
     * @description default constructor. Sets the inherited named credential
     * to the DEFAULTNAMEDCREDENTIAL constant above.
     * Setting the namedCredentialName binds all the methods in this class
     * to the specific namedCredential URL and auth.
     */
    public ApiServiceClass() {
        namedCredentialName = NAMEDCREDENTIAL;
        
    }

  
    public List<ApiServiceRecipesDataModel> getCurrentData() {
    
     Map<String, String> defaultHeaders = new Map<String, String>();
       defaultHeaders.put('Content-Type','application/json');
       defaultHeaders.put('Accept','application/json');
       defaultHeaders.put('API-Key','11-111-111');
     
        HttpResponse response = get(ENDPOINT,'',defaultHeaders,false,'');
       
      
        switch on response.getStatusCode() {
            when 200 {
                try {
                    return ApiServiceRecipesDataModel.parse(response.getBody());
                } catch (System.JSONException jse) {
                    throw new ApiServiceClass.ApiException(jse.getMessage());
                }
            }
            // you probably want to handle other response codes like 30x as well
            when 404 {
                throw new ApiServiceClass.ApiException('404 error!');
            }
            when else {
                throw new ApiServiceClass.ApiException(
                    'Unexpected Response code: ' + response.getStatusCode()
                );
            }
        }
    }
}