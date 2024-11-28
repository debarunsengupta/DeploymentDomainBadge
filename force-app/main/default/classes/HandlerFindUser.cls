public with sharing class HandlerFindUser implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session) {
        String key = '%' + params[0] + '%';
        List<user> users= 
            [SELECT Id,Phone_UUID__c FROM user
             WHERE  name LIKE :key];
        
        List<BotRecord> records = new List<BotRecord>();
        
        for (user u : users) {
            List<BotField> fields = new List<BotField>();
            fields.add(new BotField('Phone UUID', u.Phone_UUID__c, '#/sObject/' + u.Id + '/view'));
            //fields.add(new BotField('Phone', c.MobilePhone, 'tel:' + c.MobilePhone));
            records.add(new BotRecord(fields));
        }
        return new BotResponse(new BotMessage('Bot', 'Here is a list of users matching "' + params[0] + '":', records));
        
    }
    
}