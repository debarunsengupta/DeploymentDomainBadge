@isTest
public class CheckPermSetAssignmentTest{
    @testSetup public static void setupData() {
     PermissionSet permSetObj = new TestPermissionSetBuilder()
                        .setPermissionSetName('TestPerm1')
              			.setPermissionSetLabel('TestPerm1')
                        .buildAndSave();
     Profile pro = [Select Id,Name FROM Profile Where Name = : 'System Administrator' LIMIT 1];
     User userObj = new TestUserBuilder()
                        .setProfileId(pro.Id)
                        .setUserName('DeaultUserName@acme.com')
                        .buildAndSave();
    }
    
    @isTest
    private static void checkPermissionSetAssignment(){
        RestRequest request = new RestRequest();
        request.httpMethod = 'GET';
        User u = [
           SELECT
            Id
           FROM
            User
           Where
            UserName = : 'DeaultUserName@acme.com'
        ];
        PermissionSet permSetName = [
            SELECT 
             Name
            FROM
             PermissionSet
            WHERE
             Name = : 'TestPerm1'
            LIMIT 1
        ];
        System.runAs(u){
            request.addParameter('permSetName',permSetName.Name);
            request.addParameter('userName', UserInfo.getName());
            RestContext.request = request;
            CheckPermSetAssignment.doGet();
        }
        RestRequest request1 = new RestRequest();
        request1.httpMethod = 'GET';
        request1.addParameter('permSetName','Service Cloud');
        request1.addParameter('userName', UserInfo.getName());
        RestContext.request = request1;
        CheckPermSetAssignment.doGet();
        
        RestRequest request2 = new RestRequest();
        request2.httpMethod = 'GET';
        request2.addParameter('permSetName','Service Cloud User');
        request2.addParameter('userName', 'Test');
        RestContext.request = request2;
        CheckPermSetAssignment.doGet();
    }
    @isTest
    private static void assignPermissionSet(){
        RestRequest request = new RestRequest();
        request.httpMethod = 'GET';
        request.addParameter('permSetName','Service Cloud User');
        request.addParameter('userName', UserInfo.getName());
        request.requestUri ='/assignPermSet?permSetName=CRM%20User&userName='+UserInfo.getName();
        System.debug('--1--'+request.requestUri);
        RestContext.request = request;
        AssignPermSet.doGet();
        
        RestRequest request1 = new RestRequest();
        request1.httpMethod = 'GET';
        request1.addParameter('permSetName','Service Cloud');
        request1.addParameter('userName', UserInfo.getName());
        request1.requestUri ='/assignPermSet?permSetName=CRM%20User&userName='+UserInfo.getName();
        System.debug('--1--'+request1.requestUri);
        RestContext.request = request1;
        AssignPermSet.doGet();
        
        RestRequest request2 = new RestRequest();
        request2.httpMethod = 'GET';
        request2.addParameter('permSetName','Service Cloud User');
        request2.addParameter('userName', 'Test');
        request2.requestUri ='/assignPermSet?permSetName=CRM%20User&userName='+UserInfo.getName();
        System.debug('--1--'+request2.requestUri);
        RestContext.request = request2;
        AssignPermSet.doGet();
    }
    
    @isTest 
    private static void checkCrudPermsPositive()
    {
        RestRequest request = new RestRequest();
        request.addParameter('objectName','Account');
        request.addParameter('profileName', 'Admin');
        request.requestUri ='/crudINFO?objectName=Account&profileName=System%20Administrator';
        System.debug('--1--'+request.requestUri);
        RestContext.request = request;
        crudInfo.doGet();   
    }
    @isTest 
    private static void checkCrudPermsNegative()
    {
        RestRequest request = new RestRequest();
        request.addParameter('objectName','Account1');
        request.addParameter('profileName', 'Admin');
        request.requestUri ='/crudINFO?objectName=Account&profileName=System%20Administrator';
        System.debug('--1--'+request.requestUri);
        RestContext.request = request;
        crudInfo.doGet();   
    }
    
    @isTest
    private static void checkBatchJobStatusNegative()
    {
        RestRequest request = new RestRequest();
        request.addParameter('batchClassName','account underscore scheduled');  
        RestContext.request = request;
        BatchJobStatus.doGet();
    }
    
        @isTest
    private static void checkBatchJobStatusPositive()
    {
        RestRequest request = new RestRequest();
        request.addParameter('batchClassName','account underscore schedule'); 
        RestContext.request = request;
        BatchJobStatus.doGet();
    }
    
            @isTest
    private static void checkBatchJobStatusPositiveNoJob()
    {
        RestRequest request = new RestRequest();
        request.addParameter('batchClassName','scheduler class');
        request.requestUri ='/BatchJobStatus?batchClassName=scheduler%20class';  
        RestContext.request = request;
        BatchJobStatus.doGet();
    }  
}