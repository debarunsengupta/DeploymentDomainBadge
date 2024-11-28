/* Class for getting account record from other salesforce org through rest api integration
by calling class and its method from other org*/

public class TestWebService{
string sessionid;
    public TestWebService(){
        //You will get "clientId","clientSecret" when creating connected app in salesforce
        String clientId = '3MVG9d8..z.hDcPL5YM4vPUw8eo2_H6NmWIxEco3VQzJzDyTJVoDMA8aOhK0qNmoUYStNkhcX3QTTqNoM_I.l';
        String clientSecret = '1216669167635232681';

        //We can also store our username password in custom setting.
        String username='debsengupta@deloitte.com';//salesforce username 
        String password='abcd1234zGGI2DVAG8Gj83dc46xXim31';//EUe4eHjMxXb8UFco1SPcpsZL9';//salesforce password
         sessionid='00D28000001Glq6!AQ4AQJxcr2J.UpmLJpjtHg21TlsrYaPCK90cizi2H1Vj6i0YSJAZ6DsKTF7zx1iceI4T2ianmgf1v_ELg8ZplS5nJzUwLQ8f';
        // Generating the Access Token
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
       // req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');// this is the OAuth endpoint where this request will be hit
        req.setBody('grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String str = res.getBody();
        wrapObj = (Wrapper)Json.deserialize(str,Wrapper.class);
        accessToken = wrapObj.access_token;
        instanceUrl = wrapObj.instance_url;
       
        methodGet();
    }
        
    // Retrieve the Contacts from the otehr org.
    public void methodGet(){
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        //req.setEndpoint(wrapObj.instance_url+'/services/apexrest/Account/getAccountById?name=champaKAli');
        
        req.setEndpoint('https://lightning-sagnik-dev-ed.my.salesforce.com/services/apexrest/Account/0017F00000fJZWiQAO');
        req.setHeader('Authorization', 'OAuth '+wrapObj.access_token);
         //req.setHeader('Authorization', 'Bearer'+wrapObj.access_token);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        System.debug('***Response***** ' + res.getBody());
        //---------------------Here ------------------
        /*JSONParser parser = JSON.createParser(res.getBody());
        do{
            parser.nextToken();
        }while(parser.hasCurrentToken() && !'records'.equals(parser.getCurrentName()));
            parser.nextToken();
        List<account> acc = (List<Account>) parser.readValueAs(List<Account>.class);*/
    }
    public Contact con {get;set;}
    public String s1 {get;set;}
    public String accessToken;
    public String instanceUrl;
    public Wrapper wrapObj{get;set;}
    // Wrapper Class to Store the value from the Jason.
    public class Wrapper{
        String id;
        String instance_url;
        String access_token;
        String issued_at;
        String signature;
    }
}