@isTest
private class AddressComponentControllerTest {
    @isTest static void testAddressFields() {
        Contact con=new Contact(firstname='Test',lastname='test');
        insert con;
        List<string> addressFields=new List<String>();
        addressFields.add('testcity');
        addressFields.add('teststate');
        Boolean addressCheck=AddressComponentController.checkAddressFields((string)con.id,addressFields);
        System.assertEquals(false,addressCheck);

    }
    
    @isTest static void testAddressAutofill() {
       Test.setMock(HttpCalloutMock.class, new AddressComponentCalloutMock()); 
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock. 
       string response = AddressComponentController.getAddressSet('test');
        System.assert(response!=null);

       

    }
      @isTest static void testAddressByPlace() {
       Test.setMock(HttpCalloutMock.class, new AddressComponentPlaceCalloutMock()); 
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock. 
       string response = AddressComponentController.getAddressDetailsByPlaceId('test');
        System.assert(response!=null);

       }
          @isTest static void testSaveAddress() {
        Contact con=new Contact(firstname='Test',lastname='test');
        insert con;
        Map<string,string>fieldApiToValue=new Map<string,string>();
        fieldApiToValue.put('Name','testcity');
        AddressComponentController.saveAddress((string)con.id,fieldApiToValue);
        System.assert(con.id!=null);

    }
         @isTest static void testAddressFieldsOnLoad() {
        Contact con=new Contact(firstname='Test',lastname='test');
        insert con;
        List<string> addressFields=new List<String>();
        addressFields.add('Name');
        Map<string,object> result=AddressComponentController.getAddressField((string)con.id,addressFields);
        System.assert(result!=null);

    }
         //mock test method to check post method in utility class
         @isTest static void testPostMethod() {
         Map<String, String> defaultHeaders = new Map<String, String>{
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
         };
         Test.setMock(HttpCalloutMock.class, new AddressComponentCalloutMock()); 
         RestClient.namedCredentialName='test'; 
         HTTPResponse resp=RestClient.post('','test',defaultHeaders,false,'');
         //HTTPResponse response=RestClient.makeApiCall('POST','','','',false,'');
         //System.assert(resp!=null);

    }
     
     //mock test method to check masterdata method in utility class
         @isTest static void testMasterData() {
         
         HTTPResponse resp=RestClient.masterDataFetch('select id,name from Account');
         System.assert(resp!=null);

    }
      
}