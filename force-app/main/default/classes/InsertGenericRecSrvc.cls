@RestResource(urlMapping='/insertGenericRecSrvc/*')
global with sharing class InsertGenericRecSrvc{

    @HttpGet
    global static String doGet(){
    
        String retStr = '';
         
        try{ 
            String objectName = RestContext.request.params.get('objectName');
            String fieldNames = RestContext.request.params.get('fieldNames');
            String fieldValues = RestContext.request.params.get('fieldValues');
            
            List<String> fieldNamesList = fieldNames.split(',');
            List<String> fieldsValueList = fieldValues.split(',');
            
            System.debug('objectName is --> ' +objectName);
            System.debug('field names are --> ' +fieldNamesList);
            System.debug('field values are --> ' +fieldsValueList);
    
            Map<String,String> objLabelVsApiMap = new Map<String,String>(); 
            Map<String,String> fieldLabelVsApiMap = new Map<String,String>(); 
            Map<String,Schema.DisplayType> fieldLabelVsTypeMap = new Map<String,Schema.DisplayType>(); 
            Map<String,Object> apiVsValue = new Map<String,Object>(); 
            
            Map<String,Schema.SObjectType> globalDesc = Schema.getGlobalDescribe();
            
            Schema.SObjectType objType = globalDesc.get(objectName);
            
            for(Schema.SObjectType obj : globalDesc.values()){
                objLabelVsApiMap.put(obj.getDescribe().getLabel(),obj.getDescribe().getName());
            }
            
            String objApi = objLabelVsApiMap.get(objectName.capitalize());
            System.debug('objApi --> '+ objApi);
            
            Schema.SObjectType sObj = globalDesc.get(objApi) ; 
            Schema.DescribeSObjectResult sObjDescRes = sObj.getDescribe() ;
            Map<String,Schema.SObjectField> fields = sObjDescRes.fields.getMap() ;
            
            System.debug('object fields --> ' +fields); 
            
            for(String field : fields.keyset()){
                Schema.DescribeFieldResult desribeResult = fields.get(field).getDescribe();
                fieldLabelVsApiMap.put(desribeResult.getLabel(),desribeResult.getName()); 
                fieldLabelVsTypeMap.put(desribeResult.getLabel(),desribeResult.getType());
            }
            
            System.debug(fieldLabelVsApiMap);
            
            for(String fieldLbl : fieldNamesList){
                System.debug(fieldLbl);
                Integer index = fieldNamesList.indexOf(fieldLbl);
                List<String> splitStr = fieldLbl.toLowerCase().split(' ');
                for (Integer i = 0; i < splitStr.size(); i++) {
                   splitStr[i] = splitStr[i].capitalize();     
                }
                String finalStr = String.join(splitStr,' ');
                System.debug('finalStr-->' + finalStr);
                if(fieldLabelVsApiMap.containsKey(finalStr)){
                    String value = fieldsValueList[index];
                    System.debug(value);
                    if(finalStr.contains('Date')){
                        System.debug(getConvertDate(value));
                        apiVsValue.put(fieldLabelVsApiMap.get(finalStr),getConvertDate(value));
                    }
                    else if(value == 'check'){
                        apiVsValue.put(fieldLabelVsApiMap.get(finalStr),true);
                    }
                    else{
                        apiVsValue.put(fieldLabelVsApiMap.get(finalStr),value);
                    }
                }
            }
            
            System.debug('field api vs value map -->' +apiVsValue);
            
            Sobject genericObject = objType.newSObject();
            
            List<sObject> objRecList = new List<sObject>();
            
            for(String apiName : apiVsValue.KeySet()){
                genericObject.put(apiName, apiVsValue.get(apiName));
            }
            
            objRecList.add(genericObject);
            
            System.debug('object record to be inserted --> '+objRecList);
            
            insert(objRecList);
            
            retStr = 'Success';
        }
        
        catch(Exception e){
            retStr = 'Failure';
            System.debug(e);
        }
        System.debug('retStr --> ' + retStr);
        return retStr; 
    }
    
    public static Date getConvertDate(String strDt){
    
        Map<String,Integer> mapMonthList = new Map<String,Integer>();
        
        mapMonthList.put('january',1);
        mapMonthList.put('January',1);
        mapMonthList.put('jan',1);
        mapMonthList.put('Jan',1);
        mapMonthList.put('february',2);
        mapMonthList.put('February',2);
        mapMonthList.put('Feb',2);
        mapMonthList.put('feb',2);
        mapMonthList.put('March',3);
        mapMonthList.put('march',3);
        mapMonthList.put('april',4);
        mapMonthList.put('April',4);
        mapMonthList.put('may',5);
        mapMonthList.put('May',5);
        mapMonthList.put('june',6);
        mapMonthList.put('June',6);
        mapMonthList.put('july',7);
        mapMonthList.put('July',7);
        mapMonthList.put('august',8);
        mapMonthList.put('August',8);
        mapMonthList.put('september',9);
        mapMonthList.put('September',9);
        mapMonthList.put('october',10);
        mapMonthList.put('October',10);
        mapMonthList.put('november',11);
        mapMonthList.put('November',11);
        mapMonthList.put('december',12);
        mapMonthList.put('December',12);
        
        String[] strDtDivided = strDt.split(' ');
        
        String day = '';
        
        String month = String.ValueOf(mapMonthList.get(strDtDivided.get(1)));
        if(strDtDivided.get(0).length() == 3){
            day = strDtDivided.get(0).substring(0,1);
        }
        else if(strDtDivided.get(0).length() == 4){
            day = strDtDivided.get(0).substring(0,2);
        }
        String year = strDtDivided.get(2);
        
        DateTime dt = System.now();
        Integer hr = dt.hour();
        Integer mn = dt.minute();
        Integer sec = dt.second();
        
        String stringDate = year + '-' + month + '-' + day + ' ' + hr + ':' + mn + ':' + sec;
        
        return Date.valueOf(stringDate);
        
    }
    
}