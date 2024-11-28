global class BatchCheckBoxRemoval implements Database.Batchable<sObject>{

	global final string query;

	global BatchCheckBoxRemoval(){
		query = 'Select Id, Record_Edited__c From Account where Record_Edited__c=true';		
   	} 
   	
   	global Database.QueryLocator start(Database.BatchableContext BC){

		return Database.getQueryLocator(query);
	}
	
	global void execute(Database.BatchableContext BC,List<Account> scope) {
    	      List<Account> updateObjs = new List<Account>();
    	
     	      for(Account s : scope) {
        	    //Your_Object__c obj = (Your_Object__c) s;
          	    s.Record_Edited__c = false;
          	    updateObjs.add(s);
      	      }  
              update updateObjs;
   	}
   	
   	global void finish(Database.BatchableContext BC) {
    	      system.debug('Batch Job to remove check boxes is complete!');
   	}	
}