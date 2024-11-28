public class AccountHandler extends TriggerHandler {
  
  public override void beforeUpdate() {
    for(Account o : (List<Account >) Trigger.new) {
      // do something
    }
  }
   public AccountHandler ()
   {
    //this.setMaxLoopCount(1);

   }
  // add overrides for other contexts
  
   public override void afterupdate() {
    List<Account> acc= [SELECT Id,Opportunity_Stage__c  FROM Account WHERE Id IN :Trigger.newMap.keySet()];
    
    //Account acc = [SELECT Id, Name,Opportunity_Stage__c FROM Account WHERE Id = :con.get(0).AccountId];

    //TriggerHandler.bypass('AccountTriggerHandler');

    acc[0].Opportunity_Stage__c = 'updated by new value sept';
     TriggerHandler.bypass('AccountHandler');
    upsert acc; // won't invoke the AccountTriggerHandler
   TriggerHandler.clearBypass('AccountHandler');


    //TriggerHandler.clearBypass('AccountTriggerHandler');

    //acc.Opportunity_Stage__c = 'With Trigger';
    //insert acc; // will invoke the AccountTriggerHandler

  }

}