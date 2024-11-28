global with sharing class CustomHighlightsController {

    @AuraEnabled
      public static string FetchTabId(string oppid) {
    string stagename;
  stagename=[select id,StageName from opportunity where id=:oppid].StageName;
       
    return stagename;
    }
    }