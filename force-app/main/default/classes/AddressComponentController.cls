/******************************************************************************************
Class Name:  AddressComponentController
Description: This class is used t0 call google location API for auto complete functionality
******************************************************************************************/
public class AddressComponentController  {
 
    
   @AuraEnabled(cacheable=true)
   public static boolean checkAddressFields(string record,List<string> addressFields){
      Boolean addressFieldTypeMatch=true;
      Id contextRecordId=(Id)record;
      String sObjName = contextRecordId.getSObjectType().getDescribe().getName();
      SObjectType objectName = ((SObject)(Type.forName('Schema.'+sObjName).newInstance())).getSObjectType();
      DescribeSObjectResult describeResult = objectName.getDescribe();
      for(string address: addressFields){
       
       if(describeResult.fields.getMap().containskey(address)&& (describeResult.fields.getMap().get(address).getDescribe().getType()== Schema.DisplayType.String || 
            describeResult.fields.getMap().get(address).getDescribe().getType()== Schema.DisplayType.TextArea)){
            continue;
         }
         else
         {
         addressFieldTypeMatch=false;
         break;
         }
      }
      system.debug('addressFieldTypeMatch' +addressFieldTypeMatch);
      return addressFieldTypeMatch;

   }
    
    //Method to call google API and fetch the address recommendations 
    @AuraEnabled
    public static String getAddressSet(String SearchText){
        Integration_Connection_Details__mdt connectionDetails=[select id, MasterLabel, API_Key__c, Endpoint__c from 
                                                                Integration_Connection_Details__mdt where MasterLabel ='Google Autocomplete'];
        String APIKey = connectionDetails.API_Key__c;
        String result = null;
        system.debug('SearchText is ' + SearchText);
       
        try{
            if(SearchText != null){
            
              string endPoint=connectionDetails.Endpoint__c +SearchText.replace(' ', '%20') + '&key=' + connectionDetails.API_Key__c;
               HttpResponse response = RestClient.get(endPoint,'',null,false,'');
               Integer statusCode = response.getStatusCode();
               if(statusCode == 200){
               result = response.getBody();
               }

                
            }
        }
        catch(exception e){
            //Handling exception
            system.debug(e.getMessage());
        }
        return result;
    }
    
    //Method to call google API and fetch the address details by addressID 
    @AuraEnabled
    public static String getAddressDetailsByPlaceId(String PlaceID){
    Integration_Connection_Details__mdt connectionDetails=[select id, MasterLabel, API_Key__c, Endpoint__c from 
                                                                Integration_Connection_Details__mdt where MasterLabel ='Google Place'];
        
    
        String result = null;
        system.debug('SearchText is ' + PlaceID);
        try{
            if(PlaceID != null){
            
               string endPoint=connectionDetails.Endpoint__c +PlaceId.replace(' ', '%20')  + '&key=' + connectionDetails.API_Key__c;
               HttpResponse response = RestClient.get(endPoint,'',null,false,'');
               Integer statusCode = response.getStatusCode();
               if(statusCode == 200){
               result = response.getBody();
               }
            }
        }
        catch(exception e){
            //Handling exception
            system.debug(e.getMessage());
        }
        return result;
    }
    @AuraEnabled
    public static void saveAddress(String recordId,Map<string,string> fieldApiToValue){
    system.debug('fieldApiToValue'+fieldApiToValue);
      try{ 
      Id contextRecordId=(Id)recordId;
      String sObjName = contextRecordId.getSObjectType().getDescribe().getName();
      Schema.SObjectType convertType = Schema.getGlobalDescribe().get(sObjName);
      Sobject genericObject = convertType.newSObject();
      genericObject.put('id',recordId);
      for(string api:fieldApiToValue.keyset()){
         genericObject.put(api,fieldApiToValue.get(api));
      }
      if(genericObject !=null){
      update genericObject;}
      }
      catch(exception e){
            //Handling exception
       system.debug(e.getMessage());
      }
    }
     @AuraEnabled(cacheable=true)
    public static Map<string,object> getAddressField(String recordId,List<String>addressFields){
    system.debug('addressFields-->'+addressFields);
      Map<string,object> fieldValueMap=new Map<string,object>(); 
      try{
       Id contextRecordId=(Id)recordId;
       String sObjName = contextRecordId.getSObjectType().getDescribe().getName();
       Schema.SObjectType convertType = Schema.getGlobalDescribe().get(sObjName);
       string query='select ';
      // string fieldList=' ';
       string fieldList=String.join( addressFields, ',' );
      /* for(string field:addressFields){
          fieldList=fieldList+field+',';
       }
       fieldList=fieldList.removeEnd(',');*/
       string finalQuery= query+ fieldList +' from '+sObjName+' where id= :recordId';
        system.debug('finalQuery-->'+finalQuery);
       List<Sobject> result=Database.query(finalQuery);
       system.debug(result);
       for(sobject obj : result){
          for(String fieldName : addressFields){
              fieldValueMap.put(fieldName, obj.get(fieldName)); 
              }
        }
        }
        catch(exception e){
            //Handling exception
       system.debug(e.getMessage());
      }
       return fieldValueMap;
        
    }
}