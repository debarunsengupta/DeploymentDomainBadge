/*
 * Description: This Apex Class exposes method(s) that can be utilized by
 * other Apex Classes to create Persistent Logs of type Error or
 * Success as opposed to native Debug Logs.
 *
 * Created By: Manjit Singh.
 *
 * Created Date: Feb 30, 2019
 *
 * Revisions: NIL
*/
public without sharing class CPO_ApexLogger {

    private Boolean isFuture = false;

    /*
        This method sets the log commit in future.
     */

    public CPO_ApexLogger setAsFuture() {
        this.isFuture = true;
        return this;
    }

    /*
        A Virtual Class that Defines the
        Structure of a Log
    */
    public virtual class Log {
        public String Type;
        public String LogType;
        public String ApexClass;
        public String Method;
        public String RecordId;
        public String Message;
        public String StackTrace;
        public Boolean isPersistedLog;
    }

    /*
        A Class that Extends the Virtual Class - Log
        to define a log of type - Error
    */
    public class Error extends Log {
        public Error(String cls, String routine, String recId, String logType, Exception ex, Boolean setAsNotDeletable) {
            this.Type = 'Error';
            this.ApexClass = cls;
            this.Method = routine;
            this.RecordId = recId;
            this.LogType = logType;
            this.Message = ex.getMessage();
            this.StackTrace = ex.getStackTraceString();
            this.isPersistedLog = setAsNotDeletable;
        }
    }

    /*
        A Class that Extends the Virtual Class - Log
        to define a log of type - Information
    */
    public class Success extends Log {
        public Success(String cls, String routine, String recId, String logType, String msg, Boolean setAsNotDeletable) {
            this.Type = 'Success';
            this.ApexClass = cls;
            this.Method = routine;
            this.RecordId = recId;
            this.LogType = logType;
            this.Message = msg;
            this.StackTrace = NULL;
            this.isPersistedLog = setAsNotDeletable;
        }
    }

    /*
        A Public Method that can be utilized by
        other Apex Classes to create a record into
        the Apex Debug Log object stating the Error
        or Information.
    */
    public void createLog(Log logToCreate) {
        Boolean logsEnabled = CPO_ApexLoggerEnableDisable__c.getInstance() != null
                && CPO_ApexLoggerEnableDisable__c.getInstance().Logs_Enabled__c;

        Boolean successLogsEnabled = CPO_ApexLoggerEnableDisable__c.getInstance() != null
                && CPO_ApexLoggerEnableDisable__c.getInstance().Success_Logs_Enabled__c;

        if (logsEnabled &&
                (logToCreate.Type == 'Error' || (logToCreate.Type == 'Success' && successLogsEnabled))) {
            if (isFuture) {
                CPO_ApexLogger.internalCreateAsynchronousLog(JSON.serialize(logToCreate));
            } else {
                CPO_ApexLogger.internalCreateSynchronousLog(logToCreate);
            }
        }
    }

    /*
        A internal Method to create a record into
        the Apex Debug Log object stating the Error
        or Success Asynchronously.
    */

    @future
    public static void internalCreateAsynchronousLog(String logJsonString) {
        Log logToCreate = (CPO_ApexLogger.Log) JSON.deserialize(logJsonString, CPO_ApexLogger.Log.class);
        CPO_ApexLogger.internalCreateSynchronousLog(logToCreate);
    }

    /*
        A internal Method to create a record into
        the Apex Debug Log object stating the Error
        or Success Synchronously.
    */

    public static void internalCreateSynchronousLog(Log logToCreate) {
        try {
            /*
                Ensure that we're well within the Governor Limits.
                The creation of the Log shouldn't disturb the execution
                of that Apex Class that utilizes this method to
                create a log.
            */
            if ((Limits.getDMLRows() < Limits.getLimitDMLRows()) &&
                    (Limits.getDMLStatements() < Limits.getLimitDMLStatements())
                    ) {
                CPO_Log__c apexDebuglog = new CPO_Log__c(
                        Type__c = logToCreate.Type,
                        Apex_Class__c = logToCreate.ApexClass,
                        Method__c = logToCreate.Method,
                        Record_Id__c = logToCreate.RecordId,
                        Log_Type__c = logToCreate.LogType,
                        Message__c = logToCreate.Message,
                        Stack_Trace__c = logToCreate.StackTrace,
                        Is_persisted__c = logToCreate.isPersistedLog
                );

                insert apexDebuglog;
            } else {
                System.debug('The Governor Limits have already been exhausted and hence failed to create a Log!');
            }
        } catch (DMLException ex) {
            System.debug('Something fatal has occurred and hence failed to create a Log! Error:' + ex.getMessage());
        }
    }
}