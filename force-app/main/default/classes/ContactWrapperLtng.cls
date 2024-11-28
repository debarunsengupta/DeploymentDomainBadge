public class ContactWrapperLtng{
    
    public class DisplayContactRecords{
        
        @AuraEnabled public Boolean isSelected;
        @AuraEnabled public String contactName;
        @AuraEnabled public String contactEmail;
        @AuraEnabled public String contactId;
        @AuraEnabled public Contact contact;
        
        public DisplayContactRecords(Contact c){
            contact = c;
            isSelected = FALSE;
            contactName = '';
            contactEmail = '';
        }
    }
}