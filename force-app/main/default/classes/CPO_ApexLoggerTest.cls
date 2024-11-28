/*
 * Description: This Apex Class contains test methods for CPO_ApexLogger.
 *
 * Created By: Manjit Singh.
 *
 * Created Date: Feb 21, 2019
 *
 * Revisions: NIL
*/

@isTest(SeeAllData = false)
public class CPO_ApexLoggerTest {
    @testSetup
    static void testSetup() {
        CPO_ApexLoggerEnableDisable__c objTestApexLogSetting = new CPO_ApexLoggerEnableDisable__c();
        objTestApexLogSetting.SetupOwnerId = UserInfo.getUserId();
        objTestApexLogSetting.Logs_Enabled__c = true;
        objTestApexLogSetting.Success_Logs_Enabled__c = true;
        insert objTestApexLogSetting;
    }

    @isTest
    static void testErrorLogInsertSynchronous() {
        try {
            Integer result = 1 / 0;
        } catch (Exception ex) {
            new CPO_ApexLogger().createLog(
                    new CPO_ApexLogger.Error(
                            'CPO_ApexLogger_Test',
                            'createErrorLog',
                            NULL,
                            'General',
                            ex,
                            true
                    )
            );

            List<CPO_Log__c> lstLogsCreated = [
                    SELECT Id, Type__c, Apex_Class__c, Method__c
                    FROM CPO_Log__c
                    WHERE Method__c = 'createErrorLog'
            ];

            System.assertEquals(1, lstLogsCreated.size());
            System.assertEquals('Error', lstLogsCreated.get(0).Type__c);
            System.assertEquals('CPO_ApexLogger_Test', lstLogsCreated.get(0).Apex_Class__c);
        }
    }

    @isTest
    static void testSuccessLogInsertSynchronous() {
        new CPO_ApexLogger().createLog(
                new CPO_ApexLogger.Success(
                        'CPO_ApexLogger_Test',
                        'createInformationLog',
                        NULL,
                        'General',
                        'Logging Information from an Apex Class - CPO_ApexLogger_Test',
                        true
                )
        );

        List<CPO_Log__c> lstLogsCreated = [
                SELECT Id, Type__c, Apex_Class__c, Method__c, Message__c
                FROM CPO_Log__c
                WHERE Method__c = 'createInformationLog'
        ];

        System.assertEquals(1, lstLogsCreated.size());
        System.assertEquals('Success', lstLogsCreated.get(0).Type__c);
        System.assertEquals('CPO_ApexLogger_Test', lstLogsCreated.get(0).Apex_Class__c);
        System.assertEquals('Logging Information from an Apex Class - CPO_ApexLogger_Test', lstLogsCreated.get(0).Message__c);
    }

    @isTest
    static void testErrorLogInsertAsynchronous() {
        try {
            Integer result = 1 / 0;
        } catch (Exception ex) {
            Test.startTest();
            new CPO_ApexLogger().setAsFuture().createLog(
                    new CPO_ApexLogger.Error(
                            'CPO_ApexLogger_Test',
                            'createErrorLog',
                            NULL,
                            'General',
                            ex,
                            true
                    )
            );

            Test.stopTest();

            List<CPO_Log__c> lstLogsCreated = [
                    SELECT Id, Type__c, Apex_Class__c, Method__c
                    FROM CPO_Log__c
                    WHERE Method__c = 'createErrorLog'
            ];
            System.assertEquals(1, lstLogsCreated.size());
            System.assertEquals('Error', lstLogsCreated.get(0).Type__c);
            System.assertEquals('CPO_ApexLogger_Test', lstLogsCreated.get(0).Apex_Class__c);
        }
    }

    @isTest
    static void testSuccessLogInsertAsynchronous() {
        Test.startTest();
        new CPO_ApexLogger().setAsFuture().createLog(
                new CPO_ApexLogger.Success(
                        'CPO_ApexLogger_Test',
                        'createInformationLog',
                        NULL,
                        'General',
                        'Logging Information from an Apex Class - CPO_ApexLogger_Test',
                        true
                )
        );
        Test.stopTest();
        List<CPO_Log__c> lstLogsCreated = [
                SELECT Id, Type__c, Apex_Class__c, Method__c, Message__c
                FROM CPO_Log__c
                WHERE Method__c = 'createInformationLog'
        ];

        System.assertEquals(1, lstLogsCreated.size());
        System.assertEquals('Success', lstLogsCreated.get(0).Type__c);
        System.assertEquals('CPO_ApexLogger_Test', lstLogsCreated.get(0).Apex_Class__c);
        System.assertEquals('Logging Information from an Apex Class - CPO_ApexLogger_Test', lstLogsCreated.get(0).Message__c);
    }
}