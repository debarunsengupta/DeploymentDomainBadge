public with sharing class AccountCreate {
@AuraEnabled
public static void createNewAccount(Account acc){
    upsert acc;
 }
}