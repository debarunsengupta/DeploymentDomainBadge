/*
 * Description: This Apex Class contains test methods for CPO_ApexLoggerPurgeBatch.
 *
 * Created By: Manjit Singh.
 *
 * Created Date: Feb 21, 2019
 *
 * Revisions: NIL
*/

@isTest(SeeAllData = false)
public class CPO_ApexLoggerPurgeBatchTest {
    @testSetup
    static void testSetup() {
        CPO_ApexLoggerEnableDisable__c objTestApexLogSetting = new CPO_ApexLoggerEnableDisable__c();
        objTestApexLogSetting.SetupOwnerId = UserInfo.getUserId();
        objTestApexLogSetting.Logs_Enabled__c = true;
        objTestApexLogSetting.Success_Logs_Enabled__c = true;
        insert objTestApexLogSetting;

        CPO_ApexLoggerConfiguration__c objLoggerConfiguration = new CPO_ApexLoggerConfiguration__c();
        objLoggerConfiguration.Delete_Persisted_Logs__c = false;
        objLoggerConfiguration.Number_of_days__c = 7;
        insert objLoggerConfiguration;

        List<CPO_Log__c> logsToBeInserted = new List<CPO_Log__c>();
        for (Integer i = 0; i < 200; i++) {
            CPO_Log__c objLog = new CPO_Log__c();
            objLog.Type__c = 'Success';
            objLog.Log_Type__c = 'General';
            objLog.Apex_Class__c = 'CPO_ApexLoggerPurgeBatchTest';
            objLog.Message__c = 'CPO_ApexLoggerPurgeBatchTest';
            objLog.Method__c = 'TestMethod';
            logsToBeInserted.add(objLog);
        }
        insert logsToBeInserted;
        for (CPO_Log__c objLog : [SELECT Id from CPO_Log__c]) {
            Test.setCreatedDate(objLog.Id, System.now().addDays(-10));
        }
    }

    @isTest
    static void testLogDeletionBatch() {
        Integer intCount = [SELECT count() from CPO_Log__c];
        System.assert(intCount == 200, '200 Logs were to be created');
        Test.startTest();
        CPO_ApexLoggerPurgeBatch objCPO_ApexLoggerPurgeBatch = new CPO_ApexLoggerPurgeBatch();
        Database.executeBatch(objCPO_ApexLoggerPurgeBatch);
        Test.stopTest();
        intCount = [SELECT count() from CPO_Log__c];
        System.assert(intCount == 0, '200 Logs were to be deleted');
    }
}