public class DynamicTableMapping {
 
  @AuraEnabled
  public list<string> headervalues{get;set;}
  @AuraEnabled
  public list<ObjectValueMap> value{get;set;}
 
  public DynamicTableMapping(list<string> headervalues,list<ObjectValueMap> value){
   this.headervalues=headervalues;
    this.value=value;
  }
  public class ObjectValueMap {
    
    @AuraEnabled
    public account account{get;set;}
    @AuraEnabled
    public list<fieldValues> values{get;set;}
    
    public ObjectValueMap(account acc,list<fieldValues> values){
        this.account=acc;
        this.values=values;
    }
}

public class FieldValues {
    @auraenabled
    public object value{get;set;}
    
    public FieldValues(object value){
        this.value=value;
    }

}



}