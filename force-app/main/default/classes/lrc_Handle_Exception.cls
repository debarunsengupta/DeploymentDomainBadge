/*
    Name: lrc_Handle_Exception
    Description: This class will be used to log the exception events.
*/
public class lrc_Handle_Exception extends Exception{
    
    // Log Exception in lrc_exception_event__c object. 
    // relatedToId : Case/object for which this error in logged.
    public static void LogException(Exception e,string relatedToId)
    {
        try
        {
            String stackTrace = e.getStackTraceString().substringBefore('\n');
            String className = stackTrace.substringAfter('.').substringBefore('.');	
            String methodName = stackTrace.substringBefore(':').substringAfter(className).substringAfter('.');
            
            //Governer Limit of executingQuery 
            String QueryLimit = '1. SOQL Queries used / SOQL Queries allowed: ' + Limits.getQueries() + '/' + Limits.getLimitQueries();
            String DMLimit = '2. Number of records queried so far /  Number allowed: ' + Limits.getDmlRows() + '/' + Limits.getLimitDmlRows();
            String DMLStat = '3. Number of DML statements used so far / Number allowed: ' +  Limits.getDmlStatements() + '/' + Limits.getLimitDmlStatements();   
            String CPUT = '4. Amount of CPU time (in ms) used so far / CPU usage time (in ms) allowed: ' + Limits.getCpuTime() + '/' + Limits.getLimitCpuTime();
            
            //Log information in object
            lrc_exception_event__c exc = new lrc_exception_event__c();
            exc.lrc_related_to_number__c=relatedToId;
            exc.lrc_govt_limit_in_executing_code__c = String.format('{0}\n{1}\n{2}\n{3}',new List<string>{QueryLimit,DMLimit,DMLStat,CPUT});
            exc.lrc_exception_message__c = e.getMessage();
            exc.lrc_exception_type__c = e.getTypeName();
            exc.lrc_line_number__c = e.getLineNumber();
            exc.lrc_stack_trace__c = e.getStackTraceString();
            exc.lrc_method_name__c=methodName;
            exc.lrc_class_name__c=className;
            database.insert(exc);         
        } 
        finally{
        }            
    } 
}