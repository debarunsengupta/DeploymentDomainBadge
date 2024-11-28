/*
    Name: lrc_roll_it_up_dashboard_class
    Description: This class will be a helper class for listing all the configurations from custom setting.
*/
public class lrc_roll_it_up_dashboard_class {

    /*
        dynamic querty to fetch data for lighting datatable
    */
    @AuraEnabled public static lightningTableWraper getsObjectRecords(String ObjectName,String fieldstoget){     
        
        List<String> lstfieldstoget = fieldstoget.split(',');
        List<lightningTableColumnWrapper> lstTableColumn = new list<lightningTableColumnWrapper> ();
        
        DescribeSObjectResult objResult = Schema.getGlobalDescribe().get(ObjectName).getDescribe();
        
        for(String field : lstfieldstoget){
            lightningTableColumnWrapper colWrapper = new lightningTableColumnWrapper();
            DescribeFieldResult fieldResult = objResult.fields.getMap().get(field).getDescribe();
            colWrapper.label = fieldResult.getLabel();
            colWrapper.fieldName = fieldResult.getName();
            colWrapper.type = String.valueof(fieldResult.getType()).toLowerCase();
            colWrapper.sortable = true;
            lstTableColumn.add(colWrapper);
        }
        
        String queryString = 'Select '+ String.escapeSingleQuotes(String.join(lstfieldstoget,','))+
            ' from '+ String.escapeSingleQuotes(ObjectName) + ' Limit 100';
        
        LightningTableWraper ltngTableWrapper = new LightningTableWraper();
        ltngTableWrapper.tableRecord = database.query(queryString);
        ltngTableWrapper.tableColumn = lstTableColumn;
        
        return ltngTableWrapper;
        
    }

    /*
        lightning datatable row level action method to perform activate, deactivate and delete
    */
    @AuraEnabled public static void perform_row_event(String record_name, string row_event){ 

        if(string.isNotBlank(record_name)){
            list<lrc_roll_up_outline2__c> record_list = [SELECT Id, Name, lrc_active__c FROM lrc_roll_up_outline2__c WHERE name =:record_name LIMIT 1];
            if(record_list!= null && !record_list.isEmpty()){
                

                switch on row_event {
                   when 'activate' {
                       record_list.get(0).lrc_active__c = TRUE;
                       update record_list;
                   }
                   when 'de_activate' {
                        record_list.get(0).lrc_active__c = FALSE;
                        update record_list;
                   }
                   when 'delete' {
                        delete record_list;
                   }
                }                
            }
        }    
    }
    
    /*
        data wrapper
    */
    public class lightningTableColumnWrapper {
        @AuraEnabled
        public string label {get;set;}
        @AuraEnabled
        public String fieldName {get;set;}
        @AuraEnabled
        public string type {get;set;}
        @AuraEnabled
        public boolean sortable {get;set;}
        
    }
    
    /*
        data wrapper
    */
    public class lightningTableWraper{
        @AuraEnabled
        public List<sObject> tableRecord {get;Set;}
        @AuraEnabled
        public List<lightningTableColumnWrapper> tableColumn {get;set;}
    }
}