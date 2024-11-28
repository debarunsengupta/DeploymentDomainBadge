@isTest public class CreateTaskSrvcTest {
    @testSetup public static void setupData(){
         Opportunity opp = new Opportunity(Name = 'ANC',CloseDate = Date.valueOf('2020-03-14') ,StageName = 'Prospecting'
                                          ,Amount = 111.00);
			insert opp;
    }
    @isTest public static void createTaskWithoutOpportunity(){
      RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      request.addParameter('oppName','ABC');
      request.addParameter('taskSubject', 'Name Stage Close Date Amount');   
      request.addParameter('taskPriority', '1');  
      RestContext.request = request;
      CreateTaskSrvc.doGet();
    }

    @isTest public static void createTaskWithOpportunity(){
      RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      request.addParameter('oppName','ANC');
      request.addParameter('taskSubject', 'Name Stage Close Date Amount');   
      request.addParameter('taskPriority', '1');  
      RestContext.request = request;
      CreateTaskSrvc.doGet();
    }
    
  @isTest public static void createTaskWithOpportunityandSubjectNull(){
      RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      request.addParameter('oppName','ANC');
      request.addParameter('taskSubject', '');   
      request.addParameter('taskPriority', '1');  
      RestContext.request = request;
      CreateTaskSrvc.doGet();
    }
    
  @isTest public static void createTaskWithOpportunityandPriorityNull(){
      RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      request.addParameter('oppName','ANC');
      request.addParameter('taskSubject', 'Name Stage C');   
      request.addParameter('taskPriority', '');  
      RestContext.request = request;
      CreateTaskSrvc.doGet();
    }
    
  @isTest public static void checkTaskforDuplicateOpportunity(){
      RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      Opportunity opp1 = new Opportunity(Name = 'ANC',CloseDate = Date.valueOf('2020-05-14') ,StageName = 'Prospecting'
                                          ,Amount = 111.00);
      Test.startTest();
      insert opp1;
      Test.stopTest();
      request.addParameter('oppName','ANC');
      request.addParameter('taskSubject', 'Name Stage C');   
      request.addParameter('taskPriority', '');  
      RestContext.request = request;
      CreateTaskSrvc.doGet();
    }
}