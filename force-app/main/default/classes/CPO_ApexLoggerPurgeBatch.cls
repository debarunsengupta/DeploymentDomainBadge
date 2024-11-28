/*
 * Description: This Apex Class runs periodically to delete all logs from
 * a specified date.
 *
 * Created By: Manjit Singh.
 *
 * Created Date: Feb 22, 2019
 *
 * Revisions: NIL
*/

global class CPO_ApexLoggerPurgeBatch implements Database.Batchable<Sobject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Integer numberOfDays = 14;
        Boolean deletePersistedLogs = false;
        if (CPO_ApexLoggerConfiguration__c.getInstance() != null
                && CPO_ApexLoggerConfiguration__c.getInstance().Number_of_days__c != null) {
            deletePersistedLogs = CPO_ApexLoggerConfiguration__c.getInstance().Delete_Persisted_Logs__c;
            numberOfDays = Integer.valueOf(CPO_ApexLoggerConfiguration__c.getInstance().Number_of_days__c);
        }

        numberOfDays = numberOfDays < 0 ? numberOfDays : numberOfDays * (-1);
        Date dateToDeleteLogs = Date.today().addDays(numberOfDays);
        System.debug(dateToDeleteLogs);
        String query = 'SELECT Id from CPO_Log__c where ' +
                'CreatedDate <= : dateToDeleteLogs ';
        if (!deletePersistedLogs) {
            query = query + ' AND Is_persisted__c  = false';
        }

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<CPO_Log__c> scope) {
        delete scope;
    }

    global void finish(Database.BatchableContext BC) {
    }
}