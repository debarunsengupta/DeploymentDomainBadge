public with sharing class SNHU_InputPicklistController {
    

    @AuraEnabled
    public static List<SNHU_InputPicklistController.lstOfPicklistValues> getPicklistValues(string associatedObjName,string fieldAPIName)
    {
        List<SNHU_InputPicklistController.lstOfPicklistValues> pickvallst=new List<SNHU_InputPicklistController.lstOfPicklistValues>();
     SNHU_InputPicklistController.lstOfPicklistValues c=new SNHU_InputPicklistController.lstOfPicklistValues();
     /*c.picklistValue='abc';
     c.picklistLabel='abc';
     pickvallst.add(c);*/
     
      c.picklistValue='def';
     c.picklistLabel='def';
      pickvallst.add(c);
      system.debug('pickvallst-->'+pickvallst);
      return pickvallst;
     }
    @AuraEnabled
    public static List<SNHU_InputPicklistController.lstOfPicklistValues> getDependentMap(string objDetail,string contrfieldApiName,string depfieldApiName)
    {
     return new List<SNHU_InputPicklistController.lstOfPicklistValues>();
     }
     public class lstOfPicklistValues
     {
      @AuraEnabled public string picklistValue{get;set;}
      @AuraEnabled public string picklistLabel{get;set;}
     }
}