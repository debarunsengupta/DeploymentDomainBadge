public with sharing class LWCController {
  
    @AuraEnabled(cacheable=true)
    public static list<Contact> getContactsDetails(String searchKey){
       
      if(searchKey=='' || searchKey==null)
      return null;
      else {
      string temp='%'+searchKey+'%';
      list<contact> contactList= [Select Id,Name, Email, Phone from Contact where Name LIKE :temp Limit 10];
         return contactList;
      }
    }
}