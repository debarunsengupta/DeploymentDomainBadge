public with sharing class ContactClass {
    public ContactClass() {

    }
    @AuraEnabled(cacheable=true)
public static List<Contact> getContactList() {
    system.debug('methodled...');
    return [SELECT Id, Name, Title, Phone, Email 
            FROM Contact limit 1];
}
}