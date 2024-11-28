/**
 * @description       : 
 * @author            : Amit Singh
 * @group             : 
 * @last modified on  : 06-03-2021
 * @last modified by  : Amit Singh
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   06-03-2021   Amit Singh   Initial Version
**/
public with sharing class QuickActionController {
    public QuickActionController() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Account> createAccount(){
        return [select id,name from Account limit 5];
    }
     @AuraEnabled(cacheable=true)
    public static List<Account> createAccount1(string recId){
        return [select id,name from Account where Id=:recId];
    }
}