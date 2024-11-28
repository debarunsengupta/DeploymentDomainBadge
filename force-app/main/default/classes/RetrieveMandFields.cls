@RestResource(urlMapping='/getMandFields/*')
global with sharing class RetrieveMandFields{

    @HttpGet
    global static List<String> doGet(){
    
        List<String> retFieldsList = new List<String>();
     
        String objLabel = RestContext.request.params.get('objectName');
        
        List<String> mandFieldsList = new List<String>();

        Map<String,String> apiVsLabelMap = new Map<String,String>(); 
        Map<String,String> fieldApiVsLabelmap = new Map<String,String>(); 
        
        Map<String,Schema.SObjectType> globalDesc = Schema.getGlobalDescribe();
        
        for(Schema.SObjectType obj : globalDesc.values()){
            apiVsLabelMap.put(obj.getDescribe().getLabel(),obj.getDescribe().getName());
        }
        
        System.debug(apiVsLabelMap);
        System.debug(objLabel);
        
        String objApi = apiVsLabelMap.get(objLabel.capitalize());
        
        System.debug(objLabel.capitalize());
        
        Schema.SObjectType sObj = globalDesc.get(objApi) ; 
        System.debug(sObj);
        Schema.DescribeSObjectResult sObjDescRes = sObj.getDescribe() ;
        Map<String,Schema.SObjectField> fields = sObjDescRes.fields.getMap() ;
        
        
        for(String field : fields.keyset()){
            Schema.DescribeFieldResult desribeResult = fields.get(field).getDescribe();
            fieldApiVsLabelmap.put(desribeResult.getName(),desribeResult.getLabel());
            if( desribeResult.isCreateable() && !desribeResult.isNillable() && !desribeResult.isDefaultedOnCreate() && fieldApiVsLabelmap.containsKey(desribeResult.getName())){    
                retFieldsList.add((fieldApiVsLabelmap.get(desribeResult.getName())));    
            }                      
        }
        
        System.debug(retFieldsList);
        
        return retFieldsList;
    }
}