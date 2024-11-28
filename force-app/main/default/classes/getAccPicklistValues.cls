public class getAccPicklistValues{
   @AuraEnabled 
   public static List<String> getPickListValues(){
       List<String> options = new List<String>();
       Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       for (Schema.PicklistEntry f: ple) {
           options.add(f.getLabel());
       }
       return options;
   }
   @AuraEnabled
    public static List<Account> getAccounts(){
        return[SELECT Name, Industry, Phone FROM Account];
    }
    @AuraEnabled
    public static Account createAccount(Account acc){
    //upsert acc;
     Account acc1;
    try
    {
   
         system.debug('Method called called-->');
      
        upsert acc;
        system.debug('Val called-->'+acc1);
        }
        catch(Exception ex)
        {
        system.debug('Val called-->'+ex.getmessage());
        }
       
    
     return acc;
     }
}