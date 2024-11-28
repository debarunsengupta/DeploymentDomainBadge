@isTest 
public class DLWC_MultiSelectControllerClassic_Test{
    static testMethod void method1() {
    DLWC_MultiSelectControllerClassicStyle con=new DLWC_MultiSelectControllerClassicStyle();
       DLWC_MultiSelectControllerClassicStyle.getPiklistValues('Account','');
      
       DLWC_MultiSelectControllerClassicStyle.fetchRecordTypeValues('Account');
       //DLWC_MultiSelectControllerClassicStyle.getRecTypeId('master','Account');
       
       DLWC_MultiSelectControllerClassicStyle.filteredPiklistValues('Account','','test1,test2');
       DLWC_MultiSelectControllerClassicStyle.fetchUserSessionId();
       //LRC_MultiSelectControllerClassicStyle.getRecTypeId('');
       Test.starttest();
        Test.setMock(HttpCalloutMock.class, new DLWC_RecordTypeHttpCalloutMock()); 
        
       DLWC_MultiSelectControllerClassicStyle.ApiCallout('Account','','');
       Test.stoptest();
       // LRC_MultiSelectControllerClassicStyle.dummymethod();
    }
}