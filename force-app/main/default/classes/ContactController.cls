public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> findContacts(string test) {
        system.debug('test---->'+test);
        String key = '%' + test + '%';
        return [
            SELECT Id, Name, Title, Phone, Email
            FROM Contact where name like :key
            LIMIT 10
        ];
    }
}