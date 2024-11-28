global class UpdateOpportunity implements Database.Batchable<sObject>{
   string query;
    Date d = system.today();
   // system.debug('The current date is'+d);
    
    global Database.querylocator start(Database.BatchableContext BC){
        Query = 'select Id ,CloseDate,Amount from Opportunity where CloseDate=:d';
        return Database.getQueryLocator(query);
        }

    global void execute(Database.BatchableContext BC, List<Opportunity> scope1){
       system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+scope1);
       List<Opportunity> finalList=new List<Opportunity>();
   for(Opportunity c:scope1)
   {
   
   c.Name='updated Data';
   //update c;
   finalList.Add(c);
   }
   update finalList;
           
        }

    global void finish(Database.BatchableContext BC){
    
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
String[] toAddresses = new String[] {'debarunsengupta2512@gmail.com'};
mail.setToAddresses(toAddresses);
mail.setSubject('Oppurtunity details');
mail.setPlainTextBody('Hi');
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }
}