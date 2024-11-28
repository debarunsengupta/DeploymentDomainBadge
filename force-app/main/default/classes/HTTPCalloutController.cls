public class HTTPCalloutController {
// Pass in the endpoint to be used using the string url
public static Integration_Callout_Details__mdt oIntegrationDet;
public static Organization org;
public static string sEndPoint;
public static string sAPIKey;
public static string sCondFlowURL;
   static
   {
     org=[select id,isSandbox from organization];
     if(org.isSandbox){
                       oIntegrationDet= [SELECT Conditional_Flow__c,Is_Sandbox__c, API_Key__c, Endpoint_URL__c, 
                       DeveloperName FROM Integration_Callout_Details__mdt 
                       where DeveloperName ='APIGEE_Callout_Sandbox'];}
                       else{
                       oIntegrationDet= [SELECT Conditional_Flow__c,Is_Sandbox__c, API_Key__c, Endpoint_URL__c, 
                       DeveloperName FROM Integration_Callout_Details__mdt 
                       where DeveloperName ='APIGEE_Callout_Developer'];
                       }
   }
    @AuraEnabled
    public static Map < String,
    Object > getCalloutResponseContents() {
    
            system.debug('oIntegrationDet val fetched-->'+oIntegrationDet);
            sEndPoint= oIntegrationDet.Endpoint_URL__c;
             sAPIKey= oIntegrationDet.API_Key__c;
        // Instantiate a new http object
        Http h = new Http();
 
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(sEndPoint+'?apikey='+sAPIKey);
        req.setMethod('GET');
 
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        System.debug('response:--> ' + res.getBody());
 
        // Deserialize the JSON string into collections of primitive data types.
        Map < String,
        Object > resultsMap = (Map < String, Object > ) JSON.deserializeUntyped(res.getBody());
        system.debug('resultsMap-->' + resultsMap);
 
        return resultsMap;
    }
     @AuraEnabled
    public static string getCalloutResponseContentsXML() {
    
           
            sCondFlowURL=oIntegrationDet.Conditional_Flow__c;
        Http h = new Http();
 
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(sCondFlowURL);
        req.setMethod('GET');
          // Send the request, and return a response
        HttpResponse res = h.send(req);
        System.debug('response line 60:--> ' + res.getBody());
        return res.getBody();
        
    }
    
}