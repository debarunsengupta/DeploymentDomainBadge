@isTest public class UpdateOppInfoSrvcTest {
    @testSetup public static void setupData(){
         Opportunity opp = new Opportunity(Name = 'ANC',CloseDate = Date.valueOf('2020-03-14') ,StageName = 'Prospecting'
                                          ,Amount = 111.00);

			insert opp;
    }
    @isTest public static void getOpptyRecPos(){
       RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      request.addParameter('oppName','ABC');
      request.addParameter('fieldNames', 'Name Stage Close Date Amount');  
      request.addParameter('fieldValues', 'ABC Prospecting 2040-01-20 1111.00');    
      RestContext.request = request;
      UpdateOppInfoSrvc.doGet();
    }
    
     @isTest public static void getOpptyRecPositive(){
      RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      Opportunity op = [
          SELECT
           ID,
           Name
          FROM
           Opportunity
          Where
           Name = : 'ANC'
      ];
      request.addParameter('oppName',op.Name);
      request.addParameter('fieldNames', 'Name Stage Close Date');   
      request.addParameter('fieldValues', 'ANC Prospecting 2040-01-20');
      RestContext.request = request;
      UpdateOppInfoSrvc.doGet();
    }
    
     @isTest public static void getOpptyRecNeg(){
       RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      Opportunity opp1 = new Opportunity(Name = 'ANC',CloseDate = Date.valueOf('2020-05-14') ,StageName = 'Prospecting'
                                          ,Amount = 111.00);
      Test.startTest();
      insert opp1;
      Test.stopTest();
      request.addParameter('oppName','ANC');
      request.addParameter('fieldNames', 'Name Stage Close Date Amount');  
      request.addParameter('fieldValues', 'ABC Prospecting 2040-01-20 1111.00');    
      RestContext.request = request;
      UpdateOppInfoSrvc.doGet();
    }
    
}