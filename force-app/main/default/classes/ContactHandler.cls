public class ContactHandler extends TriggerHandler {
  
  public override void beforeUpdate() {
    for(Contact o : (List<Contact >) Trigger.new) {
      // do something
    }
  }
  public ContactHandler () {
    this.setMaxLoopCount(1);
  }
  // add overrides for other contexts
  
   public override void afterupdate() {
    List<contact> con= [SELECT Id, AccountId,Languages__c FROM contact WHERE Id IN :Trigger.newMap.keySet()];
    
    Account acc = [SELECT Id, Name,Opportunity_Stage__c FROM Account WHERE Id = :con.get(0).AccountId];

    TriggerHandler.bypass('AccountHandler');

    acc.Opportunity_Stage__c = 'updated val';
    upsert acc; // won't invoke the AccountTriggerHandler

    //TriggerHandler.clearBypass('AccountHandler');
       
    //acc.Opportunity_Stage__c = 'With Trigger';
    //upsert acc; // will invoke the AccountTriggerHandler

  }

}