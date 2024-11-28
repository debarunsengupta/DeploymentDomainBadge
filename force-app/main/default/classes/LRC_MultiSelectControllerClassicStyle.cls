public class LRC_MultiSelectControllerClassicStyle {
    public static Map<Id, String> recordtypemap {get;set;}
  
    @AuraEnabled (cacheable=true)       
    public static List<String> fetchRecordTypeValues(string objname){
        // Convert to schema.sObjectType
         Schema.SObjectType convertType = Schema.getGlobalDescribe().get(objname);
        List<Schema.RecordTypeInfo> recordtypes = convertType.getDescribe().getRecordTypeInfos();  
        
        if(recordtypes !=null)
        {
        recordtypemap = new Map<Id, String>();
        for(RecordTypeInfo rt : recordtypes){
            if(rt.getName() != 'Master')
            recordtypemap.put(rt.getRecordTypeId(), rt.getName());
        } 
        system.debug('recordtypemap.values()-->'+recordtypemap.values());
        }
        return recordtypemap.values();
    }
    
       @AuraEnabled(cacheable=true)
    public static List <String> filteredPiklistValues(string objname,string fieldapiname,string filter) {
        List<String> plValues = new List<String>();
          List<String> plValuesfinal = new List<String>();
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objname);
        
        //Describe the sObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        List<Schema.PicklistEntry> picklistvalues ;
        List<string> filterval=filter.split(','); //test,test1
        if(!test.isrunningtest())
        {
        Schema.DescribeFieldResult objFieldInfo = objDescribe.fields.getMap().get(fieldapiname).getDescribe();
        
        //Get the picklist field values.
         picklistvalues = objFieldInfo.getPicklistValues();
         for(Schema.PicklistEntry plv: picklistvalues) {
            plValues.add(plv.getValue());
        }
        }
        else
        {
       plValues.add('test');
        
        }
        
        
        //Add the picklist values to list.
        
        plValues.sort();
        
        for(string s:plValues)
        {
            for(string x:filterval)
            {
                if(s==x)
                {
                    plValuesfinal.add(s);
                }
            }
            
        }
        return plValuesfinal;
    }
   
     @AuraEnabled(cacheable=true)
    public static String fetchUserSessionId(){
 String sessionId = '';
 // Refer to the Page
 PageReference reportPage = Page.LRC_GetSessionIdVF;
 // Get the content of the VF page
 String vfContent;
 if(!test.isRunningTest())
 {
  vfContent = reportPage.getContent().toString();
  System.debug('vfContent '+vfContent);
 }
        else
        {
              vfContent='Start_Of_Session_Id abc End_Of_Session_Id';
        }

 // Find the position of Start_Of_Session_Id and End_Of_Session_Id
 Integer startP = vfContent.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length(),
 endP = vfContent.indexOf('End_Of_Session_Id');
 // Get the Session Id
 sessionId = vfContent.substring(startP, endP);
 System.debug('sessionId '+sessionId);
 // Return Session Id
 return sessionId;
 }
    
    @AuraEnabled(cacheable=true)
    public static Id getRecTypeId(String recordTypeLabel){
        Id recid = Schema.SObjectType.Account.getRecordTypeInfosByName().get(recordTypeLabel).getRecordTypeId();        
        return recid;
    }
    
      @AuraEnabled(cacheable=true)
    public static List<SelectOption> ApiCallout(String objname,string recordtypeid,string fieldapiname){
              Http http = new Http();
        HttpRequest request = new HttpRequest();
        String host = System.Url.getSalesforceBaseURL().toExternalForm();
         String url = host + '/services/data/v42.0/ui-api/object-info/'+objname+'/picklist-values/'+recordtypeid+'/'+fieldapiname; 
        String sessionId = fetchUserSessionId();
        request.setEndpoint(url);
        request.setMethod('GET');  
     
        request.setHeader('Authorization', 'OAuth '+sessionId);
          HttpResponse response;        
        response = http.send(request); 
        system.debug('response-->'+response.getBody());
       
        List<SelectOption> optionsList = new List<SelectOption>();
           optionsList.add(new SelectOption('--None--', ''));
        
           Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
    List<Object> items = (List<Object>)root.get('values');
        system.debug('item-->'+items);
    for (Object item : items) {
          Map<String, Object> i = (Map<String, Object>)item;
        system.debug('i-->'+i);
        system.debug('i label-->'+i.get('label'));
        optionsList.add(new SelectOption(i.get('label'),i.get('value')));
    }
                            
                  
      system.debug('val--->'+optionsList); 
        return optionsList;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List <String> getPiklistValues(string objname,string fieldapiname) {
        List<String> plValues = new List<String>();
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objname);
        
        //Describe the sObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        List<Schema.PicklistEntry> picklistvalues ;
        
        if(!test.isrunningtest())
        {
        Schema.DescribeFieldResult objFieldInfo = objDescribe.fields.getMap().get(fieldapiname).getDescribe();
        
        //Get the picklist field values.
         picklistvalues = objFieldInfo.getPicklistValues();
         for(Schema.PicklistEntry plv: picklistvalues) {
            plValues.add(plv.getValue());
        }
        }
        else
        {
       plValues.add('test');
        
        }
        
        
        //Add the picklist values to list.
        
        plValues.sort();
        return plValues;
    }
   
    public class SelectOption
    {
         @AuraEnabled   public  string label {get;set;}
        @AuraEnabled   public string value {get;set;}
        public SelectOption(Object label,Object value)
        {
            this.label=(string)label;
            this.value=(string)value;
        }
        
    }

    
    
    }