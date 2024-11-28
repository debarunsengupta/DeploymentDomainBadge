global class DataExportBatch implements Database.Batchable<String>,Database.Stateful{

    global Backup__c backupObj {get;set;}
    
    global Iterable<String> start(Database.BatchableContext BC){
        backupObj = new Backup__c(Name=String.valueOf(System.today()));
        insert backupObj;
        List <String> objList = new list <String> ();
        for ( Schema.SObjectType obj : Schema.getGlobalDescribe().values()){
            Schema.DescribeSObjectResult objResult = obj.getDescribe();
            if(objResult.isUpdateable() && objResult.isQueryable() && objResult.isDeletable() && objResult.isSearchable()){
                if(objResult.getName() != 'IdeaComment'){
                    objList.add(objResult.getName());
                }         
            }
        }
        return objList;
    }
    
    
    global void execute(Database.BatchableContext BC, List<String> scope){
        
        for(String straa : scope) {
            String queryString = 'SELECT ';
            Map <String, Schema.SObjectField> mapf = Schema.getGlobalDescribe().get(straa).getDescribe().fields.getMap();
            String csvContent='Id,';
            for (String fieldName: mapf.keySet()) {
                String ketValue = (String) mapf.get(fieldName).getDescribe().getname();
                csvContent = csvContent + ketValue + ',';
                queryString = queryString + ketValue + ',';
            }
            csvContent = csvContent.subString(0,csvContent.lastIndexOf(','));
            csvContent = csvContent + '\n';
            queryString = queryString.subString(0,queryString.lastIndexOf(','));
            queryString = queryString + ' FROM ' + straa;
            List<sObject> sobjList = Database.query(queryString);
            for(sObject obj : sobjList){
                csvContent = csvContent + obj.get('Id') + ',';
                for (String fieldName: mapf.keySet()) {
                    if (mapf.get(fieldName).getDescribe().isCustom() || mapf.get(fieldName).getDescribe().isNameField()) {
                        String ketValue = (String) mapf.get(fieldName).getDescribe().getname();
                        String escapedCSVContent;
                        if(String.valueOf(obj.get(ketValue))!= null && String.valueOf(obj.get(ketValue)).contains(',')){
                            escapedCSVContent = String.valueOf(obj.get(ketValue)).escapeCsv();
                        }else{
                            escapedCSVContent = String.valueOf(obj.get(ketValue));
                        }
                        csvContent = csvContent + escapedCSVContent  + ',';
                    }
                }
                csvContent = csvContent.subString(0,csvContent.lastIndexOf(','));
                csvContent = csvContent + '\n';
            }
            csvContent = csvContent.replace('null','');
            
            // Create csv
            Blob csvBlob = Blob.valueOf(csvContent);
            Attachment attchmnt = new Attachment();
            attchmnt.Body = csvBlob;
            attchmnt.Name = straa + '-' +system.today() + '.csv' ;
            attchmnt.ParentId = backupObj.Id; 
            insert attchmnt;
        }
    }
    
    global void finish(Database.BatchableContext BC){
      
    }
    
    
    
}