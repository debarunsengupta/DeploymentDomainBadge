/*
    Name: lrc_Handle_Exception
    Description: This class is the entry point to the roll ups. This class will middle manage the configurations and results.
*/
public class lrc_roll_it_up_class {
    
    //This method method will prepare the config vs roll up list and finalise the sObject DML list
    public static void rollUp(map<id,sobject> triggerNewMap, map<id,sobject> triggerOldMap, boolean isDelete) {
        try {
            map<string, list<sobject>> final_map = new map<string, list<sobject>>();
            
            Id objId = isDelete ? triggerOldMap.values()[0].Id : triggerNewMap.values()[0].Id;
            string objName = string.valueOf(objId.getSObjectType());
            list<lrc_roll_up_outline2__c> config = [SELECT Name, Id, filter_criteria__c, lrc_roll_up_mechanism__c, lrc_roll_up_operation_type__c, lrc_source_field__c, lrc_source_object__c, lrc_target_field__c, lrc_target_object__c, lrc_target_object_relation__c 
                                                    FROM lrc_roll_up_outline2__c WHERE lrc_source_object__c=:objName AND lrc_active__c = TRUE];      
            
            if(config != null && !config.isEmpty()){
                
                for(lrc_roll_up_outline2__c roll: config){
                    list<sobject> dml_records = rollUp(triggerNewMap, triggerOldMap, isDelete, roll);
                    list<sobject> map_records = final_map.get(roll.lrc_target_object__c);
                    System.debug('**' + dml_records);
                    System.debug('**' + map_records);
                    System.debug('**' + roll.Name);
                       
                    list<sobject> merge_records = null;
                    if(dml_records!=null && map_records!=null){
                        merge_records = mergeLists(map_records, dml_records, roll.lrc_target_field__c);
                        final_map.put(roll.lrc_target_object__c, merge_records);
                    }else if(map_records==null && dml_records!=null){
                        final_map.put(roll.lrc_target_object__c, dml_records);
                    }
                }
                list<sObject> final_list = new list<sObject>();
                if(final_map!=null && !final_map.isEmpty()){
                    for(string s: final_map.keyset()){
                        final_list.addAll(final_map.get(s));
                    }
                }
                if(final_list!= null && !final_list.isEmpty())update final_list;
            }
        } catch (Exception e) {
            string rel_id = '';
            lrc_Handle_Exception.LogException(e, rel_id);
        }       
    }
    
    //This method method will prepare the all the parent ids where roll up config needs to be executed
    public static list<sobject> rollUp(map<id,sobject> triggerNewMap, map<id,sobject> triggerOldMap, boolean isDelete, lrc_roll_up_outline2__c config) {
        map<id, sobject> detailRecordsFromTrigger = isDelete ? triggerOldMap : triggerNewMap;
        Set<Id> masterRecordIds = new Set<Id>(); 
        for (Id kid : detailRecordsFromTrigger.keySet()) {
            //Parent not null check
            Id mId = (Id)detailRecordsFromTrigger.get(kid).get(config.lrc_target_object_relation__c);
            if(mId != null) masterRecordIds.add(mId);
            
            //Repratent check
            if(!isDelete && triggerOldMap != null && triggerOldMap.get(kid).get(config.lrc_target_object_relation__c) != null && triggerNewMap.get(kid).get(config.lrc_target_object_relation__c) != triggerOldMap.get(kid).get(config.lrc_target_object_relation__c) ){
                masterRecordIds.add((Id)triggerOldMap.get(kid).get(config.lrc_target_object_relation__c));
            }
        }
        return rollUp(masterRecordIds, config);
    }
    
    //This method method will prepare the context for roll up execution
    public static list<sobject> rollUp(set<id> object_ids, lrc_roll_up_outline2__c config) {
        
        try {
            if(config != null){
                Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
                Schema.DescribeFieldResult relField = gd.get(config.lrc_source_object__c).getDescribe().fields.getMap().get(config.lrc_target_object_relation__c).getDescribe();
                Schema.SObjectType pObj = gd.get(config.lrc_target_object__c);
                Schema.SObjectType cObj = gd.get(config.lrc_source_object__c);
                string fil = string.isNotBlank( config.filter_criteria__c ) ? config.filter_criteria__c : '';
                
                lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(pObj, cObj, relField, fil); 
                
                Schema.DescribeFieldResult pField = gd.get(config.lrc_target_object__c).getDescribe().fields.getMap().get(config.lrc_target_field__c).getDescribe();
                Schema.DescribeFieldResult cField = gd.get(config.lrc_source_object__c).getDescribe().fields.getMap().get(config.lrc_source_field__c).getDescribe();
                string op = config.lrc_roll_up_operation_type__c;  //revisit here  
                ctx.add( new lrc_roll_it_up_helper_class.RollupSummaryField(pField, cField, op ));  
                
                return lrc_roll_it_up_helper_class.rollUp(ctx, object_ids);
            }  
        } catch (Exception e) {
            string rel_id = '';
            if(config != null) rel_id = config.Id;
            lrc_Handle_Exception.LogException(e, rel_id);
        }    
        return null;
    }  
    
    //This method will help merging the 2 lists.
    public static list<sObject> mergeLists(list<sobject> l1, list<sobject> l2, string field2){
            
        map<id, sobject> map1;
        map<id, sobject> map2;
        map<id, sobject> map3 = new map<id, sobject>();    
        
        if( l1!= null )map1 = new map<id, sobject>(l1); 
        if( l2!= null )map2 = new map<id, sobject>(l2); 
        
        if( map1 != null && !map1.isEmpty()){
            for(id rec_id: map1.keyset()){
                sobject s1 = map1.get(rec_id);      
                if(map2!=null && map2.get(rec_id) != null){
                    sobject s2 = map2.get(rec_id);
                    s1.put(field2, s2.get(field2) );
                }
                map3.put(s1.id, s1);
            }
        }
        
        if( map2 != null && !map2.isEmpty()){
            for(id rec_id: map2.keyset()){  
                sobject s = map2.get(rec_id);            
                if(!map3.containsKey(rec_id)){
                    map3.put(s.id, s);
                }
            }
        }
        
        return map3.values();
    }
}