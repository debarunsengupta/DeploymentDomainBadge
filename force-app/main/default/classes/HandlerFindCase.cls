public with sharing class HandlerFindCase implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session) {
        String key = '%' + params[0] + '%';
        List<Case> cases= 
            [SELECT Id,subject FROM case
             WHERE subject LIKE :key
             ORDER BY subject 
             LIMIT 5];
        
        List<BotRecord> records = new List<BotRecord>();
        
        for (case c : cases) {
            List<BotField> fields = new List<BotField>();
            fields.add(new BotField('subject', c.subject , '#/sObject/' + c.Id + '/view'));
            //fields.add(new BotField('Phone', c.MobilePhone, 'tel:' + c.MobilePhone));
            records.add(new BotRecord(fields));
        }
        return new BotResponse(new BotMessage('Bot', 'Here is a list of cases matching "' + params[0] + '":', records));
        
    }
    
}