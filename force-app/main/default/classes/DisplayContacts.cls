public class DisplayContacts{
    
    @AuraEnabled
    public static List<ContactWrapperLtng.DisplayContactRecords> getContactWrapperRecords(){
        List<ContactWrapperLtng.DisplayContactRecords> lstContactWrapper = new List<ContactWrapperLtng.DisplayContactRecords>();
        List<Contact> lstContacts = [SELECT Name, Email FROM Contact LIMIT 3];
        if(lstContacts!=NULL && !lstContacts.isEmpty()){
            for(Contact contact:lstContacts){
                ContactWrapperLtng.DisplayContactRecords contactWrapper = new ContactWrapperLtng.DisplayContactRecords(contact);
                contactWrapper.contactName = contact.Name;
                contactWrapper.contactEmail = contact.Email;
                contactWrapper.contactId = contact.Id;
                lstContactWrapper.add(contactWrapper);
            }
        }
        return lstContactWrapper;
    }
    
    @AuraEnabled
    public static void performAction(String contactWrapper){
    system.debug('contactWrapper:' +contactWrapper);
    //system.debug('Test deserialize'+json.deserialize(contactWrapper,List<ContactWrapperLtng.DisplayContactRecords>.class));
    //contactWrapper= '{' + contactWrapper;
    //string test=JSON.serialize(contactWrapper);
    //get top level map
   system.debug('-->'+JSON.deserialize(contactWrapper, List<ContactWrapperLtng.DisplayContactRecords>.class));
   //List<string> test=(List<String>)System.JSON.deserialize(contactWrapper, List<String>.class);
   //system.debug('test:' +test);
        List<Contact> selectedContacts = new List<Contact>();
        if(!String.isBlank(contactWrapper)){
            List<ContactWrapperLtng.DisplayContactRecords> lstContactWrapper = (List<ContactWrapperLtng.DisplayContactRecords>)JSON.deserialize(contactWrapper, List<ContactWrapperLtng.DisplayContactRecords>.class);
            //List<ContactWrapperLtng.DisplayContactRecords> lstContactWrapper = (List<ContactWrapperLtng.DisplayContactRecords>)System.JSON.deserialize(test, ContactWrapperLtng.DisplayContactRecords.class);
            
            System.debug('--List of Contact Wrapper Records--'+lstContactWrapper);
            
            for(ContactWrapperLtng.DisplayContactRecords contWrapper:lstContactWrapper){
                if(contWrapper.isSelected){
                    selectedContacts.add(contWrapper.contact);
                }
            }
            
            
            System.debug('--Selected Contacts--'+selectedContacts);
            try{
                Database.delete(selectedContacts);
            }
            catch(Exception e){
                System.debug('--Exception Caught--'+e);
            }
        }
        
    }
}