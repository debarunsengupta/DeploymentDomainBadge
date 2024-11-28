/*
 * Description: This Apex Class schedules the batch that
 * runs periodically to delete all logs from
 * a specified date.
 *
 * Created By: Manjit Singh.
 *
 * Created Date: Feb 22, 2019
 *
 * Revisions: NIL
*/

public class CPO_ApexLoggerPurgeScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        CPO_ApexLoggerPurgeBatch objCPO_ApexLoggerPurgeBatch = new CPO_ApexLoggerPurgeBatch();
        Database.executeBatch(objCPO_ApexLoggerPurgeBatch, 200);
    }
}