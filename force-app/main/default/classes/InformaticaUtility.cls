public class InformaticaUtility {
    

    public static String userName;
    public static String passWord;
     public static string endpoint;
    public static String accessTokenURL;
    public static String jobname;
     public static String jobtype;
    
    static {
      
             Informatica_Connection__mdt connectiondetails;
            connectiondetails = [Select Auth_Token_URL__c,End_Point__c,Job_Name__c,Job_Type__c,Password__c, User_Name__c From Informatica_Connection__mdt Where label = 'Informatica Connection'];
            
       
        
        passWord = connectiondetails.Password__c;
        userName = connectiondetails.User_Name__c ;
        accessTokenURL=connectiondetails.Auth_Token_URL__c;
        jobname=connectiondetails.Job_Name__c;
        jobtype=connectiondetails.Job_Type__c;
        endpoint=connectiondetails.End_Point__c;
    }
  
   
    public static Response InvokeInformaticaJob(string recid)
    {
        //string reqBody = '{"Accounts": ' + '[' + JSON.serialize(request, false) + ']' + '}';
       // system.debug('JSON Serialized string---->' + reqBody);
        
        InformaticaRequestResponse req=new InformaticaRequestResponse();
        Map<string,string> tempmap=new Map<string,string>();
        tempmap.put('@type','job');
        req.type=tempmap;
        //req.type.put('@type',jobtype);
        req.taskName=jobname;
        req.taskType=jobtype;
        system.debug('req-->'+req);
        //string reqBody = '{"Accounts": ' + '[' + JSON.serialize(request, false) + ']' + '}';
        string reqBody=JSON.serialize(req, true); //{"type":{"@type":"DSS"},"taskType":"DSS","taskName":"DSS_SFDC_ACCOUNT_ORALCL"}
        system.debug('req string-->'+reqBody);

        string reqBody1=reqBody.remove('"type":{');
        system.debug('req string1-->'+reqBody1); //{"@type":"DSS"},"taskType":"DSS","taskName":"DSS_SFDC_ACCOUNT_ORALCL"}
         integer index = reqBody1.indexOf('}');
         string stringtoremove='}';
         string result;
         if(index !=-1)
         {
         system.debug('found match');
          result = reqBody1.substring(0, index) + 
                    reqBody1.substring(index + stringtoremove.length());
                    system.debug('found match final'+result);
         }
        
        HttpRequest request = new HttpRequest();
        request.setBody(result);
        HttpResponse response=SendRequest(request,'POST');
         //SendRequest(request,'POST');
         
        string responseString=response.getBody().remove('\"');
        //InformaticaRequestResponse res = (InformaticaRequestResponse)JSON.deserialize(responseString, InformaticaRequestResponse.class);

        Response r=new Response();
        r.statusmessage=response.getBody().remove('\"');
        r.statuscode =response.getStatusCode();
        Account acc=[select id,Record_Changed__c,Record_Processed__c from Account where id=:recid];
        if(response.getStatusCode()==200)
        {
          acc.Record_Processed__c=true;
            acc.Record_Changed__c=false;
           update acc;
        }
        
        update acc;
        return r;
        
    }
    
    public static HttpResponse SendRequest(HttpRequest req, String method) {
        
       InformaticaTokenDetail getTokenDetails=AccessToken();
        
        String sessionid = getTokenDetails.icSessionId;
        
        
        Http h = new Http();
        req.setMethod(method);
        req.setEndpoint(endpoint);
       
        req.setHeader('icSessionId',sessionid);
       
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept', 'application/json');
        //req.setHeader('Host', host);
        
        
        HttpResponse res;
     
            system.debug('request utility: '+req);
            res = h.send(req);
            system.debug('**** Response utility: ');
            system.debug(res);
            system.debug(res.getBody());
    
        return res;
        
    }
    
    public static InformaticaTokenDetail AccessToken() {
        
          InformaticaRequestResponse req=new InformaticaRequestResponse();
          req.username=userName;
          req.password=passWord;
           Map<string,string> tempmap=new Map<string,string>();
        tempmap.put('@type','login');
        req.type=tempmap;
          
          string reqBody=JSON.serialize(req, true); //{"type":{"@type":"DSS"},"taskType":"DSS","taskName":"DSS_SFDC_ACCOUNT_ORALCL"}
        system.debug('req string-->'+reqBody);

        string reqBody1=reqBody.remove('"type":{');
        system.debug('req string1-->'+reqBody1); //{"@type":"DSS"},"taskType":"DSS","taskName":"DSS_SFDC_ACCOUNT_ORALCL"}
         integer index = reqBody1.indexOf('}');
         string stringtoremove='}';
         string result;
         if(index !=-1)
         {
         system.debug('found match');
          result = reqBody1.substring(0, index) + 
                    reqBody1.substring(index + stringtoremove.length());
                    system.debug('found match final'+result);
         }
         
         
        InformaticaTokenDetail getTokenDetails = new InformaticaTokenDetail();
        
        Http h = new Http();
        
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(accessTokenURL);
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setBody(result);
        
           
            HttpResponse res = h.send(request);
            
            System.debug('Status - '+res.toString());
            System.debug('Response'+res.getbody());
            getTokenDetails = (InformaticaTokenDetail)JSON.deserialize(res.getbody(), InformaticaTokenDetail.class);
         
        
        return getTokenDetails;
        
    }

    
    
}