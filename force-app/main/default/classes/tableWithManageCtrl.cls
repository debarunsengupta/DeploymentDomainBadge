public class tableWithManageCtrl {
    @AuraEnabled
    public static List < account > fetchAccount() {
        
        List < Account > returnList = new List < Account > ();
        
        for (Account acc: [select id, Name, Type, Industry, Phone, Fax from account LIMIT 10]) {
            returnList.add(acc);
        }
        return returnList;
    }
     @AuraEnabled
    public static string fetchfieldname()
    {
    String type='Account';
    List<string> fldlist=new List<string>();
List<tableWithManageCtrl.wrapper> wrapclasslist=new List<tableWithManageCtrl.wrapper>();
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType leadSchema = schemaMap.get(type);
            Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();


                for (String fieldName: fieldMap.keySet()) {

//System.debug('##Field API Name='+fieldName);// list of all field API name

 tableWithManageCtrl.wrapper wrap =new tableWithManageCtrl.wrapper();
 wrap.label=fieldMap.get(fieldName).getDescribe().getLabel();
 wrap.value=fieldMap.get(fieldName).getDescribe().getLabel();
 wrapclasslist.add(wrap);

//fldlist.add(fieldMap.get(fieldName).getDescribe().getLabel());//It provides to get the object fields label.
}
 System.debug('##Field Label Name='+fldlist);// list of all field API name  
 string s=Json.serialize(wrapclasslist);
 system.debug('s--->'+s);
 return s; 
    }
    
    public class wrapper
    {
   @AuraEnabled public string label{get;set;}
    @AuraEnabled public string value{get;set;}
    }
}