@isTest public class RunBatchJobTest {
    @isTest
    private static void checkRunBatchJobNegative()
    {
        RestRequest request = new RestRequest();
        request.addParameter('batchClassName','account underscore scheduled');
        request.addParameter('batchSize', '');
        RestContext.request = request;
        RunBatchJob.doGet();
    }
    
    @isTest
    private static void checkRunBatchJobWithBatchSizeNegative()
    {
        RestRequest request = new RestRequest();
        request.addParameter('batchClassName','account underscore scheduled');
        request.addParameter('batchSize', '22');
        RestContext.request = request;
        RunBatchJob.doGet();
    }
    
    @isTest
    private static void checkBatchJobStatusInvClass()
    {
        RestRequest request = new RestRequest();
        request.addParameter('batchClassName','account underscore scheduled');
        request.addParameter('batchSize', '22');
        RestContext.request = request;
        RunBatchJob.doGet();
        
        Object obj = RunBatchJob.createInstance('abc');
    }
}