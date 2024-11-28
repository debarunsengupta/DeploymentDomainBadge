@RestResource(urlMapping='/getOpptyInfo/*')
global with sharing class OppInfoSrvc{

    @HttpGet
    global static String doGet(){
        
        String returnResp = '';
        try{
            String oppName = RestContext.request.params.get('oppName').capitalize();
            String fieldNames = RestContext.request.params.get('fieldNames');
            String resp = '';
            
            List<String> respList = new List<String>();
            
            
            List<String> fieldNamesList = fieldNames.split(',');
            
            
            List<Opportunity> oppList = [SELECT Id,StageName,CloseDate,Amount FROM Opportunity WHERE Name =: oppName ORDER BY LastModifiedDate DESC];
            
            
            for(String fieldName : fieldNamesList){
                if(fieldName.containsIgnoreCase('stage')){
                    respList.add(oppList[0].StageName);
                }
                if(fieldName.containsIgnoreCase('amount')){
                    respList.add(String.valueOf(oppList[0].Amount));
                }
                if(fieldName.containsIgnoreCase('date')){
                    respList.add(String.valueOf(oppList[0].CloseDate));
                }
            }
            
            if(!respList.isEmpty() && respList.size() > 1){
                resp = String.join(respList,',');
            }
            else if(!respList.isEmpty() && respList.size() == 1){
                resp = respList[0];
            }
            
            System.debug(resp);
            
            if(!oppList.isEmpty() && oppList.size()>1){
                if(!String.isBlank(resp)){
                    returnResp = 'Please note that there are more than one Opportunity with the same name.' + ' ' + fieldNames + ' on ' + oppName + ' Opportunity ' + ' is ' + resp;
                }
                
                else{
                    returnResp = 'error while fetching info';
                }
                
            }
            else if(!oppList.isEmpty() && oppList.size() == 1){
                returnResp = fieldNames.capitalize() + ' on ' + oppName + ' is ' + resp;
            }
            else if(oppList.isEmpty()){
                returnResp = 'Opportunity ' + oppName + ' is not present.';
            }
            
            System.debug(returnResp);
        }
        catch(Exception e){
            returnResp = 'Exception encountered. Please report this issue to your admin team.';  
            System.debug(e.getStackTraceString()); 
        }
        return returnResp;
        
    }
}