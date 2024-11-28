/*
	Name: download_csv_apex
	Description: This class will be used to query all the configs for downloading the CSV.
*/
public class lrc_download_csv_apex {
    @AuraEnabled public static list<lrc_roll_up_outline2__c> fetch_data(){        
       return [SELECT Name, filter_criteria__c, lrc_active__c, lrc_last_process_date_time__c, lrc_roll_up_mechanism__c, lrc_roll_up_operation_type__c, lrc_source_field__c, lrc_source_object__c, lrc_target_field__c, lrc_target_object__c, lrc_target_object_relation__c FROM lrc_roll_up_outline2__c];
    }
}