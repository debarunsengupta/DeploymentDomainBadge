global class MMRAGStatusUpdate implements 
    Database.Batchable<sObject> {
    
    // instance member to retain state across transactions
    //global Integer recordsProcessed = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID,MM_RAG_Status__c, (SELECT ID,activitydate,MM_RAG_Status_Dependent__c FROM openactivities where MM_RAG_Status_Dependent__c=true) FROM case' 
        );
    }

    global void execute(Database.BatchableContext bc, List<case> scope){
        // process each batch of records
        
        Map<Id,List<openactivity>> casetotask= new Map<Id,List<openactivity>>();
        Date todaydate=system.today();
        set<Id> caseidred=new set<Id>();
        set<Id> caseidamber=new set<Id>();
        set<Id> caseidgreen=new set<Id>();
        List<Case> caselist=new List<Case>();
        for(case eachcase: scope)
        {
            //List<openactivity> entitiesForKey = casetotask.get(eachcase.Product__c);

                 casetotask.put(eachcase.id,eachcase.openactivities); //5000K00000xrbE4QAI -->[{"Id":"00T0K00001hfeF5UAI","ActivityDate":"2017-10-24","MM_RAG_Status_Dependent__c":true},{"Id":"00T0K00001hfeFKUAY","ActivityDate":null,"MM_RAG_Status_Dependent__c":true},{"Id":"00T0K00001hfeElUAI","ActivityDate":"2017-11-02","MM_RAG_Status_Dependent__c":true}]
            
        }
  

       for(Id mapkey:casetotask.keyset())
       {
           List<openactivity> opact=casetotask.get(mapkey);
           
           for(openactivity eachtask: opact)
           {
               Integer daysbetween=todaydate.daysBetween(eachtask.activitydate);
               system.debug('daysbetween-->'+daysbetween);
               
               if(daysbetween==2) //assuming 2 is for Red 
               {
                   
                   caseidred.add(mapkey);
                   break;
               }
               else if(daysbetween==3) //assuming 3 is for Amber
               {
                   
                   caseidamber.add(mapkey);
                   break;
                   
               }
                else if(daysbetween==4) //assuming 4 is for Yellow
               {
                    
                   caseidgreen.add(mapkey);
               }
           }
       }    
       if(caseidred.size() >0 || !caseidred.isempty())
       {
       List<Case> casetobeupdated=[select id,MM_RAG_Status__c from case where id in :caseidred];
       
       for(Case c: casetobeupdated)
       {
           c.MM_RAG_Status__c='Red';
           caselist.add(c);
       }
       }
        else if(caseidamber.size() >0 || !caseidamber.isempty())
       {
       List<Case> casetobeupdated=[select id,MM_RAG_Status__c from case where id in :caseidamber];
       
       for(Case c: casetobeupdated)
       {
           c.MM_RAG_Status__c='Amber';
           caselist.add(c);
       }
       }
        else if(caseidgreen.size() >0 || !caseidgreen.isempty())
       {
       List<Case> casetobeupdated=[select id,MM_RAG_Status__c from case where id in :caseidgreen];
       
       for(Case c: casetobeupdated)
       {
           c.MM_RAG_Status__c='Green';
           caselist.add(c);
       }
       }
       if(caselist.size() >0 || !caselist.isempty())
       {
      update caselist;
       }
    }   
    global void finish(Database.BatchableContext bc){
        
    }    

}