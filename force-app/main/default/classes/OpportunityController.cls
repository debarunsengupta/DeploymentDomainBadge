public with sharing class OpportunityController {

    @AuraEnabled
    public static List<Opportunity> getOpportunities() {
        List<Opportunity> opportunities = 
                [SELECT Id, Name, CloseDate FROM Opportunity];
        return opportunities;
    }

   
}