public class ContactTrgUtils {
 
    //Method called by the Contact Trigger to set the approver in an approval process
    public static void SetApprover(List<Contact> trgNew, boolean isUpdate, boolean isInsert, boolean isDelete, boolean isAfter){
        //Only fire this logic if the trigger is a Before Update trigger
        if(!isAfter && isUpdate){
            
            //Collection to hold all of the ids for the user records who are owners of the contact in trgNew
            Set<Id> ownerIDs = new Set<Id>();
            
            //We will use a map to hold the results of our query so we can stay bulkified
            Map<Id,User> ownerMap = new Map<Id,User>();
            
            //loop though trgNew and get all of the IDs
            for(Contact cont : trgNew){
                //Only add the owner ID if the trigger fired as a result of an Approval Process' Initial Submission Action
                if(cont.In_Approval__c){
                    ownerIDs.add(cont.OwnerId);
                }
            }
            
            //Now let's query all of the user records and add them to out map
            for(User u : [select id from User where Id in :ownerIDs]){
                ownerMap.put(u.Id,u);
            }
            
            //this is a collection we will fill up with user records to be updated in bulk at the end of this method
            List<User> ownersToUpdate = new List<User>();
            
            //loop through trgNew again and set the Special Approver. 
            for(Contact cont : trgNew){
                if(cont.In_Approval__c){
                    //get ther user record form the map
                    User owner = ownerMap.get(cont.OwnerId);
                    //use out helper method to set the Special Approver
                    //owner.Special_Approver__c = getApprover(cont).Id;
                    //add it to the list to be updated
                    ownersToUpdate.add(owner);
                }
            }
            
            //if there are record to update, upedate em
            if(!ownersToUpdate.isEmpty()){
                update ownersToUpdate;
            }
        }
    }
    
    //This is a helper method used to determin the Approver for a contact record
    private static User getApprover(Contact cont){
        User approver = [select id from user where username = 'testapprover@gmail.com'];
        
        //business logic for selecting an approver. Replace the sample logic below with your own
        
        //====Start Example Code=============================================================
        if(cont.MailingState == 'TX'){
            approver = [select id from user where username = 'testapprover@gmail.com'];
        }
        else{
            approver = [select id from user where username = 'testapprover@gmail.com'];
        }
        //======End Example Code=============================================================
        
        return approver;
    }
}