@isTest
global class LRC_RecordTypeHttpCalloutMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"controllerValues":{},"defaultValue":null,"url":"/services/data/v42.0/ui-api/object-info/Account/picklist-values/01228000000XVcHAAW/SLA__c","values":[{"attributes":null,"label":"Gold","validFor":[],"value":"Gold"},{"attributes":null,"label":"Silver","validFor":[],"value":"Silver"},{"attributes":null,"label":"Platinum","validFor":[],"value":"Platinum"},{"attributes":null,"label":"Bronze","validFor":[],"value":"Bronze"}]}');
        response.setStatusCode(200);
        return response; 
    }
}