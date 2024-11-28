@RestResource(urlMapping='/updateOpptyInfo/*')
global with sharing class UpdateOppInfoSrvc{
    
    @HttpGet
    global static String doGet(){
        
        
        String oppName = RestContext.request.params.get('oppName');
        String fieldNames = RestContext.request.params.get('fieldNames');
        String fieldValues = RestContext.request.params.get('fieldValues');
        
        List<String> fieldNamesList = fieldNames.split(',');
        List<String> fieldsValueList = fieldValues.split(',');
        
        String retResp,resp = '';
        List<String> respList = new List<String>();
        try{   
            List<Opportunity> oppList = [SELECT Id,StageName,CloseDate,Amount FROM Opportunity WHERE Name =: oppName ORDER BY LastModifiedDate DESC];
            
            if(!oppList.isEmpty() && oppList.size() > 0){
                Opportunity updOpp = new Opportunity();
                updOpp.Id = oppList[0].Id;
            
            
                for(String fieldName : fieldNamesList){
                    Integer index = fieldNamesList.indexOf(fieldName);
                    if(fieldName.containsIgnoreCase('stage')){
                        updOpp.StageName =  fieldsValueList[index];
                        respList.add('Opportunity Stage');
                    }
                    if(fieldName.containsIgnoreCase('amount')){
                        updOpp.Amount =  Decimal.valueOf(fieldsValueList[index]);
                        respList.add('Opportunity Amount');
                    }
                    if(fieldName.containsIgnoreCase('date')){
                        String dateStr = fieldsValueList[index];
                        updOpp.CloseDate =  InsertGenericRecSrvc.getConvertDate(dateStr);
                        respList.add('Opportunity Close Date');
                    }
                }
                
                update updOpp;
                
                if(!respList.isEmpty() && respList.size() > 1){
                    resp = String.join(respList,',');
                }
                if(!respList.isEmpty() && respList.size() == 1){
                    resp = respList[0];
                }
                
                if(oppList.size() > 1){
                    retResp = 'Please note that there are more than one Opportunity with the same name.' + ' ' + resp.capitalize()  + ' on most recent Opportunity named ' + oppName + ' has been updated.';
                }
                else if(oppList.size() == 1){
                    retResp = resp.capitalize() + ' on ' + oppName + ' has been updated.';
                }    
            }
            else if(oppList.isEmpty()){
                retResp = 'Could not find Opportunity ' + oppName.capitalize() + ' to update. Please retry with the correct Opportunity Name.';    
            }
        }
        catch(Exception e){
            System.debug(e.getStackTraceString());
            retResp = 'Exception Encountered. Request you to report this issue to your admin team.';
        }
        
        
        return retResp;
    }
}