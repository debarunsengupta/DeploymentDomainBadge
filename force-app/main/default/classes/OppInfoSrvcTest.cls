@isTest public class OppInfoSrvcTest {
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
      RestContext.request = request;
      OppInfoSrvc.doGet();
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
      RestContext.request = request;
      OppInfoSrvc.doGet();
     }
    
        @isTest public static void getOpptyRecPositive(){
       RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      request.addParameter('oppName','ANC');
      request.addParameter('fieldNames', 'Name Stage Close Date Amount');    
      RestContext.request = request;
      OppInfoSrvc.doGet();
    }
    
            @isTest public static void getOpptyRecPositiveNeg(){
       RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      request.addParameter('oppName','ANC');
      request.addParameter('fieldNames', 'Stage');    
      RestContext.request = request;
      OppInfoSrvc.doGet();
    }
}