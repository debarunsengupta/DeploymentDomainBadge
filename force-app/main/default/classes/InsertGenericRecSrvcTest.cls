@isTest public class InsertGenericRecSrvcTest {
    @isTest public static void getGenericSobjectRec(){
       RestRequest request = new RestRequest();
      request.httpMethod = 'GET';
      request.addParameter('objectName','Opportunity');
      request.addParameter('fieldNames', 'Name Stage Close Date');
      request.addParameter('fieldValues', 'ABC Prospecting 2nd Jan 2020');      
      RestContext.request = request;
      InsertGenericRecSrvc.doGet();
    }
}