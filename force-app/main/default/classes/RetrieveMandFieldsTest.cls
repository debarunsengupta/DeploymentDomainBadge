@isTest public class RetrieveMandFieldsTest {
    @testSetup public static void setupData(){
        
    }
    @isTest
    private static void getMandFieldsPositive(){
      RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      request.addParameter('objectName','Account');
      RestContext.request = request;
      RetrieveMandFields.doGet();
    }
}