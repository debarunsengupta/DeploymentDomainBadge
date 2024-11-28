public without sharing class IndirectRelationshipController {

    @AuraEnabled(cacheable=false)
    public static List<AccountContactRelation> getIndirectContactsToAccount(string acctid, Integer recDisplay){
     //Integer rec= Integer.valueof(noOfRecs);
    List<AccountContactRelation> recs = [
        SELECT Contact.Id, Contact.FirstName, Contact.LastName, 
    Contact.Phone, Contact.Account.Id, Contact.Account.Name,
    Contact.Title, Contact.Email, 
     IsDirect, Roles
  FROM AccountContactRelation 
  WHERE AccountId = :acctid and IsDirect=false
  ORDER BY Contact.LastName LIMIT: recDisplay                
];
return recs;
    }
}