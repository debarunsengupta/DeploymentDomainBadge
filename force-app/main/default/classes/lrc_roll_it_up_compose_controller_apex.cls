/*
    Name: lrc_roll_it_up_compose_controller_apex
    Description: This class will be a helper class for finding metada information for lookups. THis class will be used to save the configuartion to the custom setting.
*/
public with sharing class lrc_roll_it_up_compose_controller_apex {
    
    private final sObject mysObject;
    
     /*
        dynamic method to accept the inputs to find metadata information for lookup
    */
    @AuraEnabled public static List < string > fetchLookUpValues(String sSearchKeyWord, String sSelectedValues) {
       list < string > returnList = new list < string > ();
        try {
            
            set<string> fileter_set = new set<string>();
            for(Roll_Up_Object_Filter__mdt filter: [SELECT MasterLabel FROM Roll_Up_Object_Filter__mdt]){
                fileter_set.add(filter.MasterLabel);
            }            
            
            Map<String, Schema.SObjectType> describeMap = Schema.getGlobalDescribe();
            if(string.isNotBlank(sSelectedValues)){
                if(sSelectedValues.containsIgnoreCase('lrc_target_object')){
                    
                    
                    for(Schema.SObjectType schemaItr: describeMap.values()){
                        string sObj = string.valueOf(schemaItr);
                        if(!schemaItr.getDescribe().getChildRelationships().isEmpty() && !fileter_set.contains(sObj) && !sObj.endsWithIgnoreCase('history') && !sObj.endsWithIgnoreCase('share')){
                            if(string.valueOf(schemaItr).containsIgnoreCase(sSearchKeyWord) ){
                                returnList.add(string.valueOf(schemaItr));
                            }
                        }
                        
                    }
                }else if(sSelectedValues.containsIgnoreCase('lrc_source_object')){
                    string sTarget = sSelectedValues.SubStringBefore(';');
                    set<string> source_object_set = new set<string>();
                    
                    for( ChildRelationship cr: Schema.getGlobalDescribe().get(sTarget).getDescribe().getChildRelationships()){
                        string sObjName = string.valueOf(cr.getChildSObject());
                        if(!fileter_set.contains(sObjName) && string.valueOf(sObjName).containsIgnoreCase(sSearchKeyWord) && !sObjName.endsWithIgnoreCase('history') && !sObjName.endsWithIgnoreCase('share')){
                            source_object_set.add(string.valueOf(cr.getChildSObject()) + '.' + string.valueOf(cr.getField()) );              
                        }
                    }
                    returnList.addAll(source_object_set); 
                }else if(sSelectedValues.containsIgnoreCase('lrc_target_field')){                
                    
                    list<string> input_lst = sSelectedValues.split('\\;');               
                    
                    string sTarget = input_lst.get(0);
                    string sOperation = input_lst.get(1);
                    
                    Map <String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(sTarget).getDescribe().fields.getMap();
                    for(Schema.SObjectField sfield : fieldMap.Values()){
                        schema.describefieldresult dfield = sfield.getDescribe();
                        string sTargetField = dfield.getName();
                        if(dfield.isUpdateable() && string.valueOf(sTargetField).containsIgnoreCase(sSearchKeyWord)){
                            returnList.add(string.valueOf(sTargetField));
                        }                    
                    }
                } else if(sSelectedValues.containsIgnoreCase('lrc_source_field' + ';' + 'field_type')){
                    
                    string sSource = sSelectedValues.SubStringBefore(';');
                    Map <String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(sSource).getDescribe().fields.getMap();
                    for(Schema.SObjectField sfield : fieldMap.Values()){
                        schema.describefieldresult dfield = sfield.getDescribe();
                        string sSourceField = string.valueOf(dfield.getName());
                        if(string.valueOf(sSourceField).containsIgnoreCase(sSearchKeyWord)){
                            returnList.add(sSourceField +';'+dfield.getType());
                        }                    
                    }
                } else if(sSelectedValues.containsIgnoreCase('lrc_source_field')){
                    list<string> input_lst = sSelectedValues.split('\\;');  
                    set<string> datatype_set = new set<string>(input_lst.get(1).split('\\,'));
                    
                    
                    string sSource = sSelectedValues.SubStringBefore(';');
                    Map <String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(sSource).getDescribe().fields.getMap();
                    for(Schema.SObjectField sfield : fieldMap.Values()){
                        schema.describefieldresult dfield = sfield.getDescribe();
                        string sSourceFieldValue = string.valueOf(dfield.getName());
                        if(datatype_set.contains( string.valueOf(dfield.getType())) && string.valueOf(sSourceFieldValue).containsIgnoreCase(sSearchKeyWord)){                        
                            returnList.add(sSourceFieldValue);
                        }                    
                    }
                } 
            }
            
            if(returnList != null && !returnList.isEmpty()) returnList.sort();
        } catch (Exception e) {
            string rel_id = '';
            lrc_Handle_Exception.LogException(e, rel_id);
        }   
        return returnList;
    }
    
    /*
        method to save the collected setup information from compose screen
    */
    @AuraEnabled public static void save_roll_up_data(string lrc_source_object, string lrc_source_field,  
                                         string lrc_target_object, string lrc_target_field, string lrc_roll_up_operation_type, 
                                         string filter_criteria, string target_object_relation) {
                                             try {
                                                 lrc_roll_up_outline2__c obj = new lrc_roll_up_outline2__c();
                                                 string sName = (lrc_target_object + '_' + lrc_target_field);
                                                 obj.name =  (sName != null && sName.length() > 38 ) ? sName.substring(0, 38) : sName;
                                                 obj.lrc_source_object__c = lrc_source_object;
                                                 obj.lrc_source_field__c = lrc_source_field;
                                                 obj.lrc_target_object__c = lrc_target_object;
                                                 obj.lrc_target_field__c = lrc_target_field;
                                                 obj.lrc_roll_up_operation_type__c = lrc_roll_up_operation_type;
                                                 obj.lrc_active__c = true;
                                                 obj.filter_criteria__c = filter_criteria;
                                                 obj.lrc_target_object_relation__c = target_object_relation;
                                                 insert obj;  
                                             } catch (Exception e) {
                                                 string rel_id = '';
                                                 lrc_Handle_Exception.LogException(e, rel_id);
                                                 throw new DMLException(e.getMessage()); 
                                             }   
                                         }
    
    /*
        method to verify the logic with a dummy SOQL for the populated criteria
    */
    @AuraEnabled public static boolean query_validator(string sQuery) {
        boolean result = true;
        
        try{
            if(string.isNotBlank(sQuery)){
                sQuery += ' LIMIT 1';
                list<sObject> result_lst = Database.Query(sQuery);
            }
        } catch (Exception e) {
            result = false;
        }   
        
        return result;   
    }    
}