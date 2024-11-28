@isTest 
public class LRC_MultiSelectControllerClassic_Test{
    static testMethod void method1() {
       LRC_MultiSelectControllerClassicStyle.getPiklistValues('Account','');
      
       LRC_MultiSelectControllerClassicStyle.fetchRecordTypeValues('Account');
       LRC_MultiSelectControllerClassicStyle.filteredPiklistValues('Account','','test1,test2');
       LRC_MultiSelectControllerClassicStyle.fetchUserSessionId();
       //LRC_MultiSelectControllerClassicStyle.getRecTypeId('');
       Test.starttest();
        Test.setMock(HttpCalloutMock.class, new LRC_RecordTypeHttpCalloutMock()); 
        
       LRC_MultiSelectControllerClassicStyle.ApiCallout('Account','','');
       Test.stoptest();
       // LRC_MultiSelectControllerClassicStyle.dummymethod();
    }
}